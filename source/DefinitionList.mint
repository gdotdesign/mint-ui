/* A definition list component. */
component Ui.DefinitionList {
  connect Ui exposing { resolveTheme }

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The data for the headers. */
  property headers : Array(Ui.Table.Header) = []

  /* The data for the rows. */
  property rows : Array(Array(Ui.Cell)) = []

  /* The size of the list. */
  property size : Number = 16

  /* The styles for the base. */
  style base {
    border: 0.0625em solid #{actualTheme.border};
    font-family: #{actualTheme.fontFamily};
    font-size: #{size}px;
    line-height: 170%;
    border-bottom: 0;
  }

  /* The styles for the details element. */
  style details {
    -webkit-appearance: none;
    appearance: none;

    &[open] {
      border-bottom: 0.1875em solid #{actualTheme.border};

      summary {
        svg {
          transform: rotate(90deg);
        }
      }
    }
  }

  /* Styles for the summary element. */
  style summary {
    font-size: 0.875em;
    font-weight: bold;

    border-bottom: 0.0625em solid #{actualTheme.border};
    padding: 0.5em 0.75em;
    box-sizing: border-box;
    min-height: 2.5em;

    align-items: center;
    display: flex;

    cursor: pointer;
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

  /* Styles for a cell. */
  style cell {
    line-height: 1;
  }

  /* Styles for a label. */
  style label {
    line-height: 1.25em;
    font-weight: bold;
    font-size: 0.75em;
    opacity: 0.5;
  }

  /* Styles for an item. */
  style item {
    padding: 0.75em;

    + * {
      border-top: 0.0625em solid #{actualTheme.border};
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the list. */
  fun render : Html {
    <div::base>
      for (cells of rows) {
        <details::details>
          <summary::summary>
            <Ui.LineGrid gap={size * 0.3125}>
              <Ui.Icon icon={Ui.Icons:CHEVRON_RIGHT}/>

              <div::cell>
                try {
                  cell =
                    cells
                    |> Array.at(0)
                    |> Maybe.withDefault(Ui.Cell::String(""))

                  <Ui.Cell cell={cell}/>
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
                      sortable = false,
                      shrink = false,
                      sortKey = "",
                      label = ""
                    })

                <div::item>
                  <div::label>
                    <{ header.label }>
                  </div>

                  <div>
                    <Ui.Cell cell={cell}/>
                  </div>
                </div>
              }
            }
          </div>
        </details>
      }
    </div>
  }
}
