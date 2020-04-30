component Ui.Checkbox {
  connect Ui exposing {
    borderRadiusCoefficient,
    surfaceBackground,
    surfaceText,
    primaryBackground,
    primaryShadow,
    primaryText
  }

  property onChange : Function(Bool, Promise(Never, Void)) = Promise.Extra.never1

  property disabled : Bool = false
  property readonly : Bool = false
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
    height: #{size * 2.125}px;
    width: #{size * 2.125}px;

    if (checked) {
      background: #{primaryBackground};
      color: #{primaryText};
    } else {
      background: #{surfaceBackground};
      color: #{surfaceText};
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      box-shadow: 0 0 0 #{size * 0.1875}px #{primaryShadow};
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
    }
  }

  style icon {
    height: #{size * 0.75}px;
    width: #{size * 0.75}px;
    fill: currentColor;

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

      <svg::icon viewBox="0 0 36 36">
        <path
          d={
            "M35.792 5.332L31.04 1.584c-.147-.12-.33-.208-.537-.208-." \
            "207 0-.398.087-.545.217l-17.286 22.21S5.877 17.27 5.687 " \
            "17.08c-.19-.19-.442-.51-.822-.51-.38 0-.554.268-.753.467" \
            "-.148.156-2.57 2.7-3.766 3.964-.07.077-.112.12-.173.18-." \
            "104.148-.173.313-.173.494 0 .19.07.347.173.494l.242.225s" \
            "12.058 11.582 12.257 11.78c.2.2.442.45.797.45.345 0 .63-" \
            ".37.795-.536l21.562-27.7c.104-.146.173-.31.173-.5 0-.217" \
            "-.087-.4-.208-.555z"
          }/>
      </svg>

    </button>
  }
}
