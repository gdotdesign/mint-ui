component Ui.Input {
  property placeholder : String = ""
  property type : String = "text"
  property value : String = ""

  property showClearIcon : Bool = true
  property disabled : Bool = false
  property readonly : Bool = false

  property onChange : Function(String, Void) = \value : String => void
  property onInput : Function(String, Void) = \value : String => void
  property onFocus : Function(Void) = \ => void
  property onClear : Function(Void) = \ => void

  property theme : Ui.Theme = Ui.defaultTheme()

  style input {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    background-color: {theme.colors.input.background};
    border: 1px solid {theme.border.color};
    border-radius: {theme.border.radius};
    color: {theme.colors.input.text};
    font-family: {theme.fontFamily};

    line-height: 14px;
    font-size: 14px;

    outline: none;
    height: 34px;
    width: 100%;

    padding: 6px 9px;
    padding-right: {paddingRight};

    &:disabled {
      background-color: {theme.colors.disabled.background};
      color: {theme.colors.disabled.text};
      border-color: transparent;
      cursor: not-allowed;
      user-select: none;
    }

    &:-moz-read-only::-moz-selection,
    &:read-only::selection {
      background: transparent;
    }

    &::-webkit-input-placeholder,
    &:-ms-input-placeholder,
    &::-moz-placeholder,
    &:-moz-placeholder {
      opacity: 0.5;
    }

    &:focus {
      box-shadow: 0 0 2px {theme.outline.fadedColor} inset,
                  0 0 2px {theme.outline.fadedColor};

      border-color: {theme.outline.color};
    }
  }

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    display: inline-block;
    position: relative;
  }

  style icon {
    fill: {theme.colors.input.text};
    position: absolute;
    cursor: pointer;
    height: 12px;
    width: 12px;
    right: 12px;
    top: 11px;

    &:hover {
      fill: {theme.hover.color};
    }
  }

  get showCloseIcon : Bool {
    showClearIcon && value != "" && Bool.not(disabled) && Bool.not(readonly)
  }

  get paddingRight : String {
    if (showCloseIcon) {
      "30px"
    } else {
      "9px"
    }
  }

  get closeIcon : Html {
    if (showCloseIcon) {
      <svg::icon
        onClick={\event : Html.Event => onClear()}
        viewBox="0 0 36 36"
        height="36"
        width="36">

        <path
          d={
            "M35.592 30.256l-12.3-12.34L35.62 5.736c.507-.507.507-1.3" \
            "32 0-1.838L32.114.375C31.87.13 31.542 0 31.194 0c-.346 0" \
            "-.674.14-.917.375L18.005 12.518 5.715.384C5.47.14 5.14.0" \
            "1 4.794.01c-.347 0-.675.14-.918.374L.38 3.907c-.507.506-" \
            ".507 1.33 0 1.837l12.328 12.18L.418 30.257c-.245.244-.38" \
            "5.572-.385.918 0 .347.13.675.384.92l3.506 3.522c.254.253" \
            ".582.384.92.384.327 0 .665-.122.918-.384l12.245-12.294 1" \
            "2.253 12.284c.253.253.58.385.92.385.327 0 .664-.12.917-." \
            "384l3.507-3.523c.243-.243.384-.57.384-.918-.01-.337-.15-" \
            ".665-.394-.91z"
          }/>

      </svg>
    } else {
      Html.empty()
    }
  }

  fun render : Html {
    <div::base>
      <input::input
        onChange={\event : Html.Event => onChange(event.target.value)}
        onInput={\event : Html.Event => onInput(event.target.value)}
        onFocus={\event : Html.Event => onFocus()}
        placeholder={placeholder}
        disabled={disabled}
        readonly={readonly}
        value={value}
        type={type}/>

      <{ closeIcon }>
    </div>
  }
}
