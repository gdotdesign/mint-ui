component Ui.Table.Td {
  connect Ui exposing { theme }

  property children : Array(Html) = []
  property align : String = "left"
  property width : String = "auto"
  property header : Bool = false

  style td {
    border: 1px solid #{theme.border.color};
    border-bottom: #{borderBottom};
    font-weight: #{fontWeight};
    text-align: #{align};
    padding: 7px 10px;
    width: #{width};
  }

  get borderBottom : String {
    if (header) {
      "2px solid " + theme.border.color
    } else {
      ""
    }
  }

  get fontWeight : String {
    if (header) {
      "bold"
    } else {
      "normal"
    }
  }

  fun render : Html {
    <td::td>
      <{ children }>
    </td>
  }
}
