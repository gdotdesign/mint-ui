enum Ui.Cell {
  Actions(Array(Tuple(String, Bool, Function(Html.Event, Promise(Never, Void)))))
  String(String)
  Number(Number)
  Code(String)
  Html(Html)
}

record Ui.Table.Header {
  sortKey : String,
  sortable : Bool,
  label : String,
  shrink : Bool
}

component Ui.Table {
  connect Ui exposing { resolveTheme }

  property onOrderChange : Function(Tuple(String, String), Promise(Never, Void)) = Promise.Extra.never1
  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property orderDirection : String = ""
  property orderBy : String = ""
  property headers : Array(Ui.Table.Header) = []
  property rows : Array(Array(Ui.Cell)) = []
  property breakpoint : Number = 1000

  state mobile : Bool = false

  use Provider.ElementSize {
    changes = (dimensions : Dom.Dimensions) { next { mobile = dimensions.width < breakpoint } },
    element = Maybe.oneOf([table, mobileTable])
  }

  style base {
    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    border: 1px solid #{actualTheme.border};
    border-collapse: collapse;

    font-family: #{actualTheme.fontFamily};
    line-height: 170%;
    width: 100%;

    td,
    th {
      text-align: left;
      padding: 0.5em 0.7em;
    }

    td + td,
    th + th {
      border-left: 1px solid #{actualTheme.border};
    }

    tr + tr td {
      border-top: 1px solid #{actualTheme.border};
    }

    th {
      border-bottom: 2px solid #{actualTheme.border};
      background: #{actualTheme.contentFaded.color};
    }
  }

  style mobile-table {
    border: 1px solid #{actualTheme.border};
    font-family: #{actualTheme.fontFamily};
    line-height: 170%;
    border-bottom: 0;
  }

  style code {
    background: #{actualTheme.contentFaded.color};
    border: 1px solid #{actualTheme.border};
    color: #{actualTheme.contentFaded.text};

    padding: 2px 6px 0px;
    border-radius: 2px;
    white-space: pre;
    font-size: 14px;
  }

  style label {
    font-weight: bold;
    line-height: 18px;
    font-size: 0.75em;
    opacity: 0.5;
  }

  style item {
    padding: 0.75em;

    + * {
      border-top: 1px solid #{actualTheme.border};
    }
  }

  style actions {
    display: grid;
  }

  style details {
    -webkit-appearance: none;
    appearance: none;

    &:nth-child(odd) summary:not(:focus):not(:hover) {
      background: #{actualTheme.contentFaded.color};
    }

    &[open] {
      border-bottom: 3px solid #{actualTheme.border};

      summary {
        background: #{actualTheme.primary.s500.color};
        color: #{actualTheme.primary.s500.text};
        border-bottom: 0;

        svg {
          transform: rotate(90deg);
        }
      }
    }
  }

  style summary {
    font-weight: bold;
    font-size: 14px;

    border-bottom: 1px solid #{actualTheme.border};
    padding: 0.5em 0.75em;
    cursor: pointer;
    align-items: center;
    height: 40px;
    box-sizing: border-box;
    display: flex;
    outline: none;

    &:focus,
    &:hover {
      background: #{actualTheme.primary.s50.color};
      color: #{actualTheme.primary.s50.text};
    }

    &::-webkit-details-marker {
      display: none;
    }
  }

  style cell {
    line-height: 1;
  }

  get actualTheme {
    resolveTheme(theme)
  }

  fun renderCell (cell : Ui.Cell) : Html {
    case (cell) {
      Ui.Cell::Code value =>
        <code::code>
          <{ value }>
        </code>

      Ui.Cell::String value =>
        <>
          <{ value }>
        </>

      Ui.Cell::Number value =>
        <>
          <{ Number.toString(value) }>
        </>

      Ui.Cell::Actions actions =>
        <div::actions>
          <Ui.LineGrid justifyContent="center">
            for (item of actions) {
              try {
                {name, disabled, action} =
                  item

                <Ui.Icon
                  disabled={disabled}
                  interactive={true}
                  onClick={action}
                  name={name}/>
              }
            }
          </Ui.LineGrid>
        </div>

      Ui.Cell::Html value => value
    }
  }

  fun render : Html {
    if (mobile) {
      <>
        <div::mobile-table as mobileTable>
          for (cells of rows) {
            <details::details>
              <summary::summary>
                <Ui.LineGrid gap={5}>
                  <Ui.Icon name="chevron-right"/>

                  <div::cell>
                    try {
                      cell =
                        cells
                        |> Array.at(0)
                        |> Maybe.withDefault(Ui.Cell::String(""))

                      renderCell(cell)
                    }
                  </div>
                </Ui.LineGrid>
              </summary>

              <div>
                for (cell of cells) {
                  try {
                    header =
                      headers[Array.indexOf(cell, cells)]
                      |> Maybe.withDefault(
                        {
                          sortKey = "",
                          sortable = false,
                          label = "",
                          shrink = false
                        })

                    <div::item>
                      <div::label>
                        <{ header.label }>
                      </div>

                      <div>
                        <{ renderCell(cell) }>
                      </div>
                    </div>
                  }
                }
              </div>
            </details>
          }
        </div>
      </>
    } else {
      <table::base as table>
        <thead>
          for (header of headers) {
            <Ui.Table.Header
              data={header}
              onOrderChange={onOrderChange}
              orderDirection={orderDirection}
              orderBy={orderBy}/>
          }
        </thead>

        <tbody>
          for (cells of rows) {
            <tr>
              for (cell of cells) {
                <td>
                  <{ renderCell(cell) }>
                </td>
              }
            </tr>
          }
        </tbody>
      </table>
    }
  }
}
