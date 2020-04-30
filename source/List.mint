component Ui.List {
  property children : Array(Html) = []

  style base {
    > * + * {
      margin-top: 5px;
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

component Ui.List.Item {
  connect Ui exposing {
    borderRadiusCoefficient,
    fontFamily,
    contentBackground,
    contentText,
    surfaceBackground,
    surfaceText,
    primaryBackground,
    primaryText
  }

  property details : Html = <></>
  property title : Html = <></>
  property image : Html = <></>

  property onClick : Function(Html.Event, Promise(Never, Void)) =
    (event : Html.Event) : Promise(Never, Void) { Promise.never() }

  property selectable : Bool = false
  property selected : Bool = false
  property href : String = ""

  style base {
    font-family: #{fontFamily};
    text-decoration: none;
    cursor: #{cursor};

    border-radius: #{15 * borderRadiusCoefficient}px;
    user-select: none;
    padding: 10px;

    if (`#{image}`) {
      grid-template-columns: min-content 1fr;
    } else {
      grid-template-columns: 1fr;
    }

    align-items: center;
    grid-gap: 5px 10px;
    display: grid;

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

  style image {
    if (`#{details}`) {
      grid-row: span 2;
    }
  }

  style title {

  }

  style details {

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
      primaryBackground
    } else {
      surfaceBackground
    }
  }

  get oddColor : String {
    if (selected) {
      primaryText
    } else {
      surfaceText
    }
  }

  get background : String {
    if (selected) {
      primaryBackground
    } else {
      contentBackground
    }
  }

  get color : String {
    if (selected) {
      primaryText
    } else {
      contentText
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

      content =
        <>
          if (`#{image}`) {
            <div::image>
              <{ image }>
            </div>
          }

          <div::title>
            <{ title }>
          </div>

          if (`#{details}`) {
            <div::details>
              <{ details }>
            </div>
          }
        </>

      if (String.isEmpty(href)) {
        <span::base
          data-selected={selectedValue}
          onClick={onClick}>

          <{ content }>

        </span>
      } else {
        <a::base
          data-selected={selectedValue}
          onClick={onClick}
          href={href}>

          <{ content }>

        </a>
      }
    }
  }
}
