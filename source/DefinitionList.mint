/* A definition list component. */
component Ui.DefinitionList {
  const DEFAULT_CELL = Ui.Cell::String("")

  const DEAFULT_HEADER =
    {
      sortable = false,
      shrink = false,
      sortKey = "",
      label = ""
    }

  /* The data for the headers. */
  property headers : Array(Ui.Table.Header) = []

  /* The data for the rows. */
  property rows : Array(Array(Ui.Cell)) = []

  /* The size of the list. */
  property size : Number = 16

  /* The styles for the base. */
  style base {
    border: 0.0625em solid var(--border);
    border-bottom: 0;

    background: var(--content-color);
    color: var(--content-text);

    font-family: var(--font-family);
    font-size: #{size}px;
    line-height: 170%;
  }

  /* The styles for the details element. */
  style details {
    -webkit-appearance: none;
    appearance: none;

    &[open] {
      border-bottom: 0.1875em solid var(--border);

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

    border-bottom: 0.0625em solid var(--border);
    padding: 0.5em 0.75em;
    box-sizing: border-box;
    min-height: 2.5em;

    align-items: center;
    display: flex;

    cursor: pointer;
    outline: none;

    &:focus,
    &:hover {
      background: var(--primary-s50-color);
      color: var(--primary-s50-text);
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
      border-top: 0.0625em solid var(--border);
    }
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
                    |> Maybe.withDefault(DEFAULT_CELL)

                  <Ui.Cell cell={cell}/>
                }
              </div>
            </Ui.LineGrid>
          </summary>

          <div>
            for (cell of cells) {
              try {
                header =
                  headers
                  |> Array.at(Array.indexOf(cell, cells))
                  |> Maybe.withDefault(DEAFULT_HEADER)

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
