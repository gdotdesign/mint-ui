component Ui.Toggle {
  connect Ui exposing { resolveTheme }

  property onChange : Function(Bool, Promise(Never, Void)) = Promise.Extra.never1
  property theme : Maybe(Ui.Theme) = Maybe::Nothing
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
      background-color: #{actualTheme.primary.s500.color};
      border-color: #{actualTheme.primary.s500.color};
      color: #{actualTheme.primary.s500.text};
    } else {
      background-color: #{actualTheme.content.color};
      border-color: #{actualTheme.border};
      color: #{actualTheme.content.text};
    }

    border-radius: #{size * actualTheme.borderRadiusCoefficient * 1.1875}px;
    border: 2px solid;

    display: inline-flex;
    align-items: center;

    font-family: #{actualTheme.fontFamily};
    font-size: #{size * 0.875}px;
    font-weight: bold;

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
      border-color: #{actualTheme.primary.s500.color};

      &::before {
        border-radius: #{size * actualTheme.borderRadiusCoefficient * 1.1875}px;
        box-shadow: 0 0 0 0.35em #{actualTheme.primary.s500.color};
        pointer-events: none;
        position: absolute;
        opacity: 0.5;
        content: "";
        bottom: 0;
        right: 0;
        left: 0;
        top: 0;
      }
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

    border-radius: #{size * actualTheme.borderRadiusCoefficient}px;
    background: #{actualTheme.surface.color};
    width: calc(50% - #{size * 0.375}px);

    transition: left 120ms;

    if (checked) {
      left: calc(100% / 2 + #{size * 0.1875}px);
    } else {
      left: #{size * 0.1875}px;
    }
  }

  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  get width : Number {
    try {
      font =
        "#{size * 0.875}px #{actualTheme.fontFamily}"

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
