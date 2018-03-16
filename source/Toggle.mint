component Ui.Toggle {
  connect Ui exposing { theme }

  property onChange : Function(Bool, Void) = \value : Bool => void
  property offLabel : String = "OFF"
  property onLabel : String = "ON"
  property disabled : Bool = false
  property readonly : Bool = false
  property checked : Bool = false
  property width : Number = 100

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    background-color: {theme.colors.input.background};
    border: 1px solid {theme.border.color};
    border-radius: {theme.border.radius};
    color: {theme.colors.input.text};
    font-family: {theme.fontFamily};
    display: inline-flex;
    position: relative;
    font-weight: bold;
    width: {width}px;
    cursor: pointer;
    font-size: 14px;
    outline: none;
    height: 34px;
    padding: 0;

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      box-shadow: 0 0 2px {theme.outline.fadedColor} inset,
                  0 0 2px {theme.outline.fadedColor};

      border-color: {theme.outline.color};
      color: {theme.outline.color};
    }

    &:disabled {
      background: {theme.colors.disabled.background};
      color: {theme.colors.disabled.text};
      cursor: not-allowed;
    }
  }

  style label {
    text-align: center;
    width: 50%;
  }

  style overlay {
    background: {theme.colors.primary.background};
    border-radius: {theme.border.radius};
    width: calc(50% - 2px);
    position: absolute;
    transition: 320ms;
    left: {left};
    bottom: 2px;
    top: 2px;
  }

  get left : String {
    if (checked) {
      "2px"
    } else {
      "50%"
    }
  }

  fun toggle : Void {
    onChange(Bool.not(checked))
  }

  fun render : Html {
    <button::base onClick={\event : Html.Event => toggle()}>
      <div::label>
        <{ onLabel }>
      </div>

      <div::label>
        <{ offLabel }>
      </div>

      <div::overlay/>
    </button>
  }
}
