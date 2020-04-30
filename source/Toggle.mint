component Ui.Toggle {
  connect Ui exposing {
    fontFamily,
    surfaceBackground,
    surfaceText,
    contentBackground,
    primaryBackground,
    primaryShadow,
    primaryText
  }

  property onChange : Function(Bool, Promise(Never, Void)) = Promise.Extra.never1
  property offLabel : String = "OFF"
  property onLabel : String = "ON"
  property disabled : Bool = false
  property checked : Bool = false
  property size : Number = 16

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    if (checked) {
      background-color: #{primaryBackground};
      color: #{primaryText};
    } else {
      background-color: #{surfaceBackground};
      color: #{surfaceText};
    }

    border-radius: #{size * 0.3}px;
    border: 0;

    font-size: #{size * 0.875}px;
    font-family: #{fontFamily};
    font-weight: bold;

    display: inline-flex;
    align-items: center;

    height: #{size * 2.375}px;
    width: #{width}px;

    position: relative;
    cursor: pointer;
    outline: none;
    padding: 0;

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      box-shadow: 0 0 0 #{size * 0.1875}px #{primaryShadow};
    }

    &:disabled {
      filter: saturate(0) brightness(0.8);
      cursor: not-allowed;
    }
  }

  style label {
    text-align: center;
    width: 50%;
  }

  style overlay {
    bottom: #{size * 0.1875}px;
    top: #{size * 0.1875}px;
    position: absolute;

    width: calc(50% - #{size * 0.375}px);
    border-radius: #{size * 0.2}px;
    background: #FFF;

    transition: left 120ms;

    if (checked) {
      left: calc(100% / 2 + #{size * 0.1875}px);
    } else {
      left: #{size * 0.1875}px;
    }
  }

  get width : Number {
    try {
      font =
        "#{size * 0.875}px #{fontFamily}"

      onWidth =
        onLabel
        |> Dom.Extra.measureText(font)
        |> Math.ceil()

      offWidth =
        offLabel
        |> Dom.Extra.measureText(font)
        |> Math.ceil()

      Math.max(offWidth, onWidth) * 2 + size * 3
    }
  }

  fun toggle : Promise(Never, Void) {
    onChange(!checked)
  }

  fun render : Html {
    <button::base
      aria-checked={Bool.toString(checked)}
      disabled={disabled}
      onClick={toggle}
      role="checkbox">

      <div::label aria-hidden="true">
        <{ onLabel }>
      </div>

      <div::label aria-hidden="true">
        <{ offLabel }>
      </div>

      <div::overlay aria-hidden="true"/>

    </button>
  }
}
