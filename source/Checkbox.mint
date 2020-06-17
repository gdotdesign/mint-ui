component Ui.Checkbox {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property onChange : Function(Bool, Promise(Never, Void)) = Promise.Extra.never1
  property disabled : Bool = false
  property checked : Bool = false
  property size : Number = 16

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    justify-content: center;
    display: inline-flex;
    align-items: center;

    position: relative;
    cursor: pointer;
    outline: none;
    padding: 0;
    border: 0;

    border-radius: #{size * actualTheme.borderRadiusCoefficient * 1.0625}px;
    border: #{size * 0.125}px solid #{actualTheme.border};
    height: #{size * 2.125}px;
    width: #{size * 2.125}px;

    if (checked) {
      background-color: #{actualTheme.primary.s500.color};
      border-color: #{actualTheme.primary.s500.color};
      color: #{actualTheme.primary.s500.text};
    } else {
      background-color: #{actualTheme.content.color};
      border-color: #{actualTheme.border};
      color: #{actualTheme.content.text};
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      border-color: #{actualTheme.primary.s500.color};
    }

    &:focus::before {
      border-radius: #{size * actualTheme.borderRadiusCoefficient * 1.1875}px;
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      pointer-events: none;
      box-shadow: 0 0 0 0.1875em #{actualTheme.primary.s500.color};
      opacity: 0.5;
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
    }
  }

  style icon {
    if (!checked) {
      opacity: 0.25;
    }
  }

  fun toggle : Promise(Never, Void) {
    onChange(!checked)
  }

  fun focus : Promise(Never, Void) {
    Dom.focus(checkbox)
  }

  fun render : Html {
    <button::base as checkbox
      aria-checked={Bool.toString(checked)}
      disabled={disabled}
      onClick={toggle}
      role="checkbox">

      <Ui.Icon
        name="checkmark"
        size={size}
        opacity={
          if (checked) {
            1
          } else {
            0.25
          }
        }/>

    </button>
  }
}
