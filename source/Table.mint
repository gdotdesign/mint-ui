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
  connect Ui exposing {
    borderColor,
    contentBackground,
    contentBackgroundFaded,
    contentText,
    fontFamily,
    primaryBackground,
    primaryText
  }

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
    background: #{contentBackground};
    border: 1px solid #{borderColor};
    border-collapse: collapse;

    font-family: #{fontFamily};
    color: #{contentText};
    line-height: 170%;
    width: 100%;

    td,
    th {
      text-align: left;
      padding: 0.5em 0.7em;
    }

    td + td,
    th + th {
      border-left: 1px solid #{borderColor};
    }

    tr + tr td {
      border-top: 1px solid #{borderColor};
    }

    th {
      border-bottom: 2px solid #{borderColor};
      background: #{contentBackgroundFaded};
    }
  }

  style mobile-table {
    border: 1px solid #{borderColor};
    font-family: #{fontFamily};
    line-height: 170%;
    border-bottom: 0;
  }

  style code {
    background: #{contentBackgroundFaded};
    border: 1px solid #{borderColor};
    color: #{contentText};

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
      border-top: 1px solid #{borderColor};
    }
  }

  style summary {
    font-weight: bold;
    font-size: 14px;

    border-bottom: 1px solid #{borderColor};
    padding: 0.5em 0.75em;
    cursor: pointer;
    display: block;
  }

  style actions {
    display: grid;
  }

  style details {
    &:nth-child(odd) summary {
      background: #{contentBackgroundFaded};
    }

    &[open] {
      border-bottom: 3px solid #{borderColor};

      summary {
        background: #{primaryBackground};
        color: #{primaryText};
        border-bottom: 0;

        svg {
          transform: rotate(90deg);
        }
      }
    }
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

                  try {
                    cell =
                      cells
                      |> Array.at(0)
                      |> Maybe.withDefault(Ui.Cell::String(""))

                    renderCell(cell)
                  }
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
