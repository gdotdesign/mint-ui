enum Ui.Cell {
  Actions(Ui.CellAction)
  Code(String)
  String(String)
  Number(Number)
  Html(Html)
}

record Ui.Table.Header {
  sortKey : String,
  sortable : Bool,
  label : String,
  shrink : Bool
}

record Ui.CellAction {
  action : Function(Promise(Never, Void)),
  disabled : Bool,
  icon : String
}

component Ui.Table {
  property headers : Array(Ui.Table.Header) = []
  property rows : Array(Array(Ui.Cell)) = []

  style base {
    border-collapse: collapse;
    background: #FFF;
    width: 100%;

    td,
    th {
      text-align: left;
      padding: 0.75em;
    }

    td + td,
    th + th {
      border-left: 1px solid #EAEAEA;
    }

    tr + tr td {
      border-top: 1px solid #EAEAEA;
    }

    th {
      border-bottom: 2px solid #EAEAEA;
      background: #FFF;
    }
  }

  style header (shrink : Bool) {
    if (shrink) {
      white-space: nowrap;
      width: 1%;
    }
  }

  style code {
    white-space: pre;
  }

  fun render : Html {
    <table::base>
      <thead>
        for (header of headers) {
          <th::header(header.shrink)>
            <{ header.label }>
          </th>
        }
      </thead>

      <tbody>
        for (cells of rows) {
          <tr>
            for (cell of cells) {
              case (cell) {
                Ui.Cell::Code value =>
                  <td>
                    <code::code>
                      <{ value }>
                    </code>
                  </td>

                Ui.Cell::String value =>
                  <td>
                    <{ value }>
                  </td>

                =>
                  <td>
                    "WTF"
                  </td>
              }
            }
          </tr>
        }
      </tbody>
    </table>
  }
}
