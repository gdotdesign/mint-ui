component Ui.Button {
  connect Ui exposing { resolveTheme }

  property onMouseDown : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onMouseUp : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  property align : String = "center"
  property type : String = "primary"
  property label : String = ""
  property href : String = ""

  property breakWords : Bool = false
  property disabled : Bool = false
  property ellipsis : Bool = true

  property size : Number = 16

  property iconBefore : String = ""
  property iconAfter : String = ""

  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  get actualTheme {
    resolveTheme(theme)
  }

  style styles {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    border-radius: #{size * actualTheme.borderRadiusCoefficient * 1.1875}px;
    border: 1px solid transparent;

    font-family: #{actualTheme.fontFamily};
    text-decoration: none;
    font-size: #{size}px;
    line-height: 130%;
    font-weight: bold;

    box-sizing: border-box;
    user-select: none;

    position: relative;
    cursor: pointer;
    outline: none;
    padding: 0;
    margin: 0;

    case (type) {
      "surface" =>
        background-color: #{actualTheme.surface.color};
        color: #{actualTheme.surface.text};

      "warning" =>
        background-color: #{actualTheme.warning.s500.color};
        color: #{actualTheme.warning.s500.text};

      "success" =>
        background-color: #{actualTheme.success.s500.color};
        color: #{actualTheme.success.s500.text};

      "primary" =>
        background-color: #{actualTheme.primary.s500.color};
        color: #{actualTheme.primary.s500.text};

      "danger" =>
        background-color: #{actualTheme.danger.s500.color};
        color: #{actualTheme.danger.s500.text};

      =>
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      case (type) {
        "success" => box-shadow: 0 0 0 0.1875em #{actualTheme.success.shadow};
        "warning" => box-shadow: 0 0 0 0.1875em #{actualTheme.warning.shadow};
        "primary" => box-shadow: 0 0 0 0.1875em #{actualTheme.primary.shadow};
        "danger" => box-shadow: 0 0 0 0.1875em #{actualTheme.danger.shadow};
        =>
      }
    }

    &:hover,
    &:focus {
      filter: brightness(0.8) contrast(1.5);
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
    }
  }

  style container {
    justify-content: #{align};
    align-items: center;
    display: flex;

    box-sizing: border-box;
    padding: 0.5em 1.2em;
    min-height: 2.375em;
  }

  style label {
    if (breakWords) {
      word-break: break-word;
    } else if (ellipsis) {
      text-overflow: ellipsis;
      white-space: nowrap;
      overflow: hidden;
    }
  }

  /* Focuses the button. */
  fun focus : Promise(Never, Void) {
    [button, anchor]
    |> Maybe.oneOf()
    |> Dom.focus()
  }

  fun render : Html {
    try {
      content =
        <div::container>
          <Ui.LineGrid gap={size * 0.5}>
            if (String.Extra.isNotEmpty(iconBefore)) {
              <Ui.Icon
                name={iconBefore}
                size={size}/>
            }

            if (String.Extra.isNotEmpty(label)) {
              <div::label>
                <{ label }>
              </div>
            }

            if (String.Extra.isNotEmpty(iconAfter)) {
              <Ui.Icon
                name={iconAfter}
                size={size}/>
            }
          </Ui.LineGrid>
        </div>

      mouseDownHandler =
        Ui.Utils.disabledHandler(disabled, onMouseDown)

      mouseUpHandler =
        Ui.Utils.disabledHandler(disabled, onMouseUp)

      clickHandler =
        Ui.Utils.disabledHandler(disabled, onClick)

      if (String.Extra.isNotEmpty(href) && !disabled) {
        <a::styles as anchor
          onMouseDown={mouseDownHandler}
          onMouseUp={mouseUpHandler}
          onClick={clickHandler}
          href={href}>

          <{ content }>

        </a>
      } else {
        <button::styles as button
          onMouseDown={mouseDownHandler}
          onMouseUp={mouseUpHandler}
          onClick={clickHandler}
          disabled={disabled}>

          <{ content }>

        </button>
      }
    }
  }
}
