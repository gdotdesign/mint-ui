component Ui.Checkbox {
  connect Ui exposing { theme }

  property onChange : Function(Bool, Void) = (value : Bool) : Void => { void }
  property disabled : Bool = false
  property readonly : Bool = false
  property checked : Bool = false

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    background-color: {theme.colors.input.background};
    border: 1px solid {theme.border.color};
    border-radius: {theme.border.radius};
    color: {theme.colors.input.text};

    justify-content: center;
    display: inline-flex;
    align-items: center;
    cursor: pointer;
    outline: none;
    height: 34px;
    width: 34px;
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

  style icon {
    transform: {transform};
    opacity: {opacity};
    fill: currentColor;
    transition: 200ms;
    height: 16px;
    width: 16px;
  }

  get opacity : String {
    if (checked) {
      "1"
    } else {
      "0"
    }
  }

  get transform : String {
    if (checked) {
      "scale(1)"
    } else {
      "scale(0.4) rotate(45deg)"
    }
  }

  fun toggle : Void {
    onChange(!checked)
  }

  fun render : Html {
    <button::base
      disabled={disabled}
      onClick={(event : Html.Event) : Void => { toggle() }}>

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
