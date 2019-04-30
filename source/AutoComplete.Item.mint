record Ui.AutoComplete.Item {
  matchString : String,
  content : Html,
  key : String
}

component Ui.AutoComplete.Item {
  connect Ui exposing { theme }

  property onSelect : Function(String, Promise(Never, Void)) =
    (selected : String) : Promise(Never, Void) { Promise.never() }

  property placeholder : String = ""
  property selected : Bool = false

  property item : Ui.AutoComplete.Item = {
    matchString = "",
    content = <></>,
    key = ""
  }

  style base {
    font-family: {theme.fontFamily};
    cursor: pointer;

    background: {background};
    border-radius: 2px;
    user-select: none;
    color: {color};
    padding: 10px;

    display: flex;

    &:hover {
      background: #2aa0ea;
      color: white;
    }

    & + * {
      margin-top: 2px;
    }
  }

  get background : String {
    if (selected) {
      theme.colors.primary.background
    } else {
      ""
    }
  }

  get color : String {
    if (selected) {
      theme.colors.primary.text
    } else {
      "hsl(210, 20%, 30%)"
    }
  }

  fun render : Html {
    try {
      selectedValue =
        if (selected) {
          "true"
        } else {
          ""
        }

      <div::base
        data-selected={selectedValue}
        onClick={() : Promise(Never, Void) { onSelect(item.key) }}>

        <{ item.content }>

      </div>
    }
  }
}
