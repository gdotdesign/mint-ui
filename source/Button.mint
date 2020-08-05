/*
Simple button component with a label and icons before or after the label.

It works in two modes:
- as a button, the `onClick` event needs to be handled
- as a link if the `href` property is not empty
*/
component Ui.Button {
  /* The mouse down event handler. */
  property onMouseDown : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* The mouse up event handler. */
  property onMouseUp : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.never1

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
  property iconBefore : Html = <></>

  /* The icon after the label. */
  property iconAfter : Html = <></>

  /* Styles for the button. */
  style styles {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    display: inline-block;

    font-family: var(--font-family);
    font-size: #{size}px;
    font-weight: bold;

    text-decoration: none;
    line-height: 130%;

    box-sizing: border-box;
    user-select: none;

    position: relative;
    cursor: pointer;
    outline: none;
    padding: 0;
    margin: 0;
    border: 0;

    case (type) {
      "warning" =>
        background-color: var(--warning-s500-color);
        color: var(--warning-s500-text);

      "success" =>
        background-color: var(--success-s500-color);
        color: var(--success-s500-text);

      "primary" =>
        background-color: var(--primary-s500-color);
        color: var(--primary-s500-text);

      "danger" =>
        background-color: var(--danger-s500-color);
        color: var(--danger-s500-text);

      "surface" =>
        background-color: var(--surface-color);
        color: var(--surface-text);

      =>
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      case (type) {
        "success" => box-shadow: 0 0 0 0.1875em var(--success-shadow);
        "warning" => box-shadow: 0 0 0 0.1875em var(--warning-shadow);
        "primary" => box-shadow: 0 0 0 0.1875em var(--primary-shadow);
        "danger" => box-shadow: 0 0 0 0.1875em var(--danger-shadow);
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
            if (Html.isNotEmpty(iconBefore)) {
              <Ui.Icon
                icon={iconBefore}
                size={size}/>
            }

            if (String.isNotEmpty(label)) {
              <div::label>
                <{ label }>
              </div>
            }

            if (Html.isNotEmpty(iconAfter)) {
              <Ui.Icon
                icon={iconAfter}
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

      if (String.isNotEmpty(href) && !disabled) {
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
