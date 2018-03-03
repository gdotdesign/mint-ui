component Ui.Button {
  property icon : Html = Html.empty()
  property type : String = "primary"
  property side : String = "left"
  property label : String = ""
  property size : Number = 14

  property disabled : Bool = false
  property readonly : Bool = false
  property outline : Bool = false

  property onMouseDown : Function(Html.Event, Void) = \event : Html.Event => void
  property onClick : Function(Html.Event, Void) = \event : Html.Event => void

  property theme : Ui.Theme = Ui.defaultTheme()

  style styles {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    border-radius: {theme.border.radius};
    font-family: {theme.fontFamily};
    display: inline-flex;
    white-space: nowrap;
    font-weight: bold;
    user-select: none;
    cursor: pointer;
    outline: none;

    height: {size * 2.42857142857}px;
    flexDirection: {flexDirection};
    padding: 0 {size * 1.5}px;

    background: {colors.background};
    color: {colors.text};
    font-size: {size}px;
    border: {border};

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      box-shadow: 0 0 2px {shadowColor} inset,
                  0 0 2px {shadowColor};

      background: {colors.focus};
      border: {focusBorder};
      color: {focusColor};
    }

    &:disabled {
      background: {theme.colors.disabled.background};
      color: {theme.colors.disabled.text};
      cursor: not-allowed;
    }
  }

  style label {
    text-overflow: ellipsis;
    grid-area: label;
    overflow: hidden;
  }

  style icon {
    height: {size}px;
    width: {size}px;
  }

  style gutter {
    width: {size * 1.42857142857}px;
  }

  get flexDirection : String {
    case (side) {
      "right" => "row-reverse"
      "left" => "row"
      => ""
    }
  }

  get focusBorder : String {
    if (outline) {
      "1px solid " + theme.outline.color
    } else {
      "1px solid transparent"
    }
  }

  get focusColor : String {
    if (outline) {
      theme.outline.color
    } else {
      colors.text
    }
  }

  get shadowColor : String {
    if (outline) {
      theme.outline.fadedColor
    } else {
      "transparent"
    }
  }

  get border : String {
    if (outline) {
      "1px solid " + theme.border.color
    } else {
      "1px solid transparent"
    }
  }

  get colors : Ui.Theme.Color {
    if (outline) {
      theme.colors.input
    } else {
      case (type) {
        "secondary" => theme.colors.secondary
        "warning" => theme.colors.warning
        "success" => theme.colors.success
        "primary" => theme.colors.primary
        "danger" => theme.colors.danger

        =>
          {
            background = "",
            focus = "",
            text = ""
          }
      }
    }
  }

  get actualIcon : Html {
    if (icon == Html.empty()) {
      Html.empty()
    } else {
      <div::icon>
        <{ icon }>
      </div>
    }
  }

  get actualGutter : Html {
    if (icon == Html.empty()) {
      Html.empty()
    } else {
      <div::gutter/>
    }
  }

  fun render : Html {
    <button::styles
      onMouseDown={onMouseDown}
      disabled={disabled}
      readOnly={readonly}
      onClick={onClick}>

      <div::label>
        <{ label }>
      </div>

      <{ actualGutter }>
      <{ actualIcon }>

    </button>
  }
}
