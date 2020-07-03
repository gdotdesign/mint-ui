/*
Simple button component with a label and icons before or after.

It works in two modes:
- as a button, the `onClick` event needs to be handled
- as a link if the `href` property is not empty
*/
component Ui.Button {
  connect Ui exposing { resolveTheme }

  /* The mouse down event handler. */
  property onMouseDown : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  /* The mouse up event handler. */
  property onMouseUp : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  /* Where to align the text in case the button is wide. */
  property align : String = "center"

  /* The type of the button. */
  property type : String = "primary"

  /* The label of the button. */
  property label : String = ""

  /* The href of the button. */
  property href : String = ""

  /* Wether or not to break the words. */
  property breakWords : Bool = false

  /* Wether or not the button is disabled. */
  property disabled : Bool = false

  /* Wether or not make the text use ellipsis if it's overflows. */
  property ellipsis : Bool = true

  /* The size of the button. */
  property size : Number = 16

  /* The icon before the label. */
  property iconBefore : String = ""

  /* The icon after the label. */
  property iconAfter : String = ""

  /* The theme for the button. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* Styles for the button. */
  style styles {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    border-radius: #{1.5625 * actualTheme.borderRadiusCoefficient}em;
    display: inline-block;

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
    border: 0;

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

  /* Styles for the container. */
  style container {
    justify-content: #{align};
    align-items: center;
    display: flex;

    box-sizing: border-box;
    padding: 0.5em 1.2em;
    min-height: 2.375em;
  }

  /* Styles for the label. */
  style label {
    if (breakWords) {
      word-break: break-word;
    } else if (ellipsis) {
      text-overflow: ellipsis;
      white-space: nowrap;
      overflow: hidden;
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Focuses the button. */
  fun focus : Promise(Never, Void) {
    [button, anchor]
    |> Maybe.oneOf()
    |> Dom.focus()
  }

  /* Renders the button. */
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
        Ui.disabledHandler(disabled, onMouseDown)

      mouseUpHandler =
        Ui.disabledHandler(disabled, onMouseUp)

      clickHandler =
        Ui.disabledHandler(disabled, onClick)

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
