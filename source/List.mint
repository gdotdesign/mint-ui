component Ui.List {
  property children : Array(Html) = []

  style base {
    > * + * {
      margin-top: 2px;
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

component Ui.List.Item {
  connect Ui exposing { fontFamily }

  property children : Array(Html) = []

  property onClick : Function(Html.Event, Promise(Never, Void)) =
    (event : Html.Event) : Promise(Never, Void) { Promise.never() }

  property selectable : Bool = false
  property selected : Bool = false
  property href : String = ""

  style base {
    font-family: #{fontFamily};
    text-decoration: none;
    cursor: #{cursor};

    border-radius: 4px;
    user-select: none;
    padding: 10px;
    display: flex;

    background: #{background};
    color: #{color};

    &:nth-child(odd) {
      background: #{oddBackground};
      color: #{oddColor};
    }

    &:hover {
      background: #{hoverBackground};
      color: #{hoverColor};
    }
  }

  get actuallySelectable : Bool {
    selectable || !String.isEmpty(href)
  }

  get hoverBackground : String {
    if (selected || actuallySelectable) {
      "#0659fd"
    } else {
      ""
    }
  }

  get hoverColor : String {
    if (selected || actuallySelectable) {
      "white"
    } else {
      "hsl(210, 20%, 30%)"
    }
  }

  get oddBackground : String {
    if (selected) {
      "#0659fd"
    } else {
      "#F6F6F6"
    }
  }

  get oddColor : String {
    if (selected) {
      "#FFF"
    } else {
      "hsl(210, 20%, 30%)"
    }
  }

  get background : String {
    if (selected) {
      "#0659fd"
    } else {
      ""
    }
  }

  get color : String {
    if (selected) {
      "#FFF"
    } else {
      "hsl(210, 20%, 30%)"
    }
  }

  get cursor : String {
    if (actuallySelectable) {
      "pointer"
    } else {
      "initial"
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

      <a::base
        data-selected={selectedValue}
        onClick={onClick}
        href={href}>

        <{ children }>

      </a>
    }
  }
}
