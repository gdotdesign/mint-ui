/* A basic button component with a label and optional icons before and after it. */
component Ui.Button {
  connect Ui exposing {
    borderRadiusCoefficient,
    fontFamily,
    primaryBackground,
    primaryShadow,
    primaryText,
    warningBackground,
    warningShadow,
    warningText,
    successBackground,
    successShadow,
    successText,
    surfaceBackground,
    surfaceShadow,
    surfaceText,
    dangerBackground,
    dangerShadow,
    dangerText
  }

  property onMouseDown : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onMouseUp : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  property breakWords : Bool = false
  property type : String = "primary"
  property label : String = ""
  property href : String = ""

  property disabled : Bool = false
  property size : Number = 16

  property iconBefore : String = ""
  property iconAfter : String = ""

  style styles {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    border-radius: #{size * borderRadiusCoefficient * 1.1875}px;
    border: 0;

    font-family: #{fontFamily};
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
        background-color: #{surfaceBackground};
        color: #{surfaceText};

      "warning" =>
        background-color: #{warningBackground};
        color: #{warningText};

      "success" =>
        background-color: #{successBackground};
        color: #{successText};

      "primary" =>
        background-color: #{primaryBackground};
        color: #{primaryText};

      "danger" =>
        background-color: #{dangerBackground};
        color: #{dangerText};

      =>
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      case (type) {
        "surface" => box-shadow: 0 0 0 #{size * 0.1875}px #{surfaceShadow};
        "success" => box-shadow: 0 0 0 #{size * 0.1875}px #{successShadow};
        "warning" => box-shadow: 0 0 0 #{size * 0.1875}px #{warningShadow};
        "primary" => box-shadow: 0 0 0 #{size * 0.1875}px #{primaryShadow};
        "danger" => box-shadow: 0 0 0 #{size * 0.1875}px #{dangerShadow};
        =>
      }
    }

    &:hover {
      filter: brightness(0.8) contrast(1.5);
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
    }
  }

  style container {
    grid-gap: #{size * 0.5}px;
    grid-auto-flow: column;
    display: inline-grid;
    align-items: center;

    padding: #{size * 0.5}px #{size * 1.2}px;
    min-height: #{size * 2.375}px;
    box-sizing: border-box;
  }

  style label {
    if (breakWords) {
      word-break: break-word;
    } else {
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
