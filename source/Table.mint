/* A sortable table component, which collapses into a definition list on small screens. */
component Ui.Table {
  connect Ui exposing { resolveTheme }

  /* The handler for the order change event. */
  property onOrderChange : Function(Tuple(String, String), Promise(Never, Void)) = Promise.Extra.never1

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The order direction either "asc" or "desc". */
  property orderDirection : String = ""

  /* The `sortKey` of the column which the content is ordered by. */
  property orderBy : String = ""

  /* The data for the headers. */
  property headers : Array(Ui.Table.Header) = []

  /* The data for the rows. */
  property rows : Array(Array(Ui.Cell)) = []

  /* The breakpoint for the mobile version. */
  property breakpoint : Number = 1000

  /* Wether or not we are displaying the mobile version. */
  state mobile : Bool = false

  use Provider.ElementSize {
    changes = (dimensions : Dom.Dimensions) { next { mobile = dimensions.width < breakpoint } },
    element = base
  }

  /* The style for the table. */
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

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the table. */
  fun render : Html {
    <div as base>
      if (mobile) {
        <Ui.DefinitionList
          headers={headers}
          rows={rows}/>
      } else {
        <table::base as table>
          <thead>
            for (header of headers) {
              <Ui.Table.Header
                orderDirection={orderDirection}
                onOrderChange={onOrderChange}
                orderBy={orderBy}
                data={header}/>
            }
          </thead>

          <tbody>
            for (cells of rows) {
              <tr>
                for (cell of cells) {
                  <td>
                    <Ui.Cell cell={cell}/>
                  </td>
                }
              </tr>
            }
          </tbody>
        </table>
      }
    </div>
  }
}
