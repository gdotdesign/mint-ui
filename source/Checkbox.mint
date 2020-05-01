component Ui.Checkbox {
  connect Ui exposing {
    borderRadiusCoefficient,
    contentBackground,
    contentText,
    borderColor,
    primaryBackground,
    primaryShadow,
    primaryText
  }

  property onChange : Function(Bool, Promise(Never, Void)) = Promise.Extra.never1
  property disabled : Bool = false
  property checked : Bool = false
  property size : Number = 16

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

    border-radius: #{size * borderRadiusCoefficient * 1.0625}px;
    border: #{size * 0.125}px solid #{borderColor};
    height: #{size * 2.125}px;
    width: #{size * 2.125}px;

    if (checked) {
      background-color: #{primaryBackground};
      border-color: #{primaryBackground};
      color: #{primaryText};
    } else {
      background-color: #{contentBackground};
      border-color: #{borderColor};
      color: #{contentText};
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      box-shadow: 0 0 0 #{size * 0.1875}px #{primaryShadow};
      border-color: #{primaryBackground};
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
