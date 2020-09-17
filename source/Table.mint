/* A sortable table component, which collapses into a definition list on small screens. */
component Ui.Table {
  /* The handler for the order change event. */
  property onOrderChange : Function(Tuple(String, String), Promise(Never, Void)) = Promise.never1

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
    background: var(--content-color);
    color: var(--content-text);

    border: 1px solid var(--border);
    border-collapse: collapse;

    font-family: var(--font-family);
    line-height: 170%;
    width: 100%;

    td,
    th {
      text-align: left;
      padding: 0.5em 0.7em;
    }

    td + td,
    th + th {
      border-left: 1px solid var(--border);
    }

    tr + tr td {
      border-top: 1px solid var(--border);
    }

    th {
      border-bottom: 2px solid var(--border);
      background: var(--content-faded-color);
    }
  }

  /* Renders the table. */
  fun render : Html {
    <div as base>
      if (mobile) {
        <Ui.DefinitionList
          headers={Array.map(.label, headers)}
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
