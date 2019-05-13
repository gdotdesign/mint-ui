component Ui.Input {
  connect Ui exposing { theme }

  property placeholder : String = "Placeholder..."
  property type : String = "text"
  property value : String = ""

  property showClearIcon : Bool = true
  property disabled : Bool = false
  property readonly : Bool = false

  property onMouseDown : Function(Html.Event, Promise(Never, Void)) = (event : Html.Event) : Promise(Never, Void) { Promise.never() }
  property onMouseUp : Function(Html.Event, Promise(Never, Void)) = (event : Html.Event) : Promise(Never, Void) { Promise.never() }
  property onKeyDown : Function(Html.Event, Promise(Never, Void)) = (event : Html.Event) : Promise(Never, Void) { Promise.never() }
  property onKeyUp : Function(Html.Event, Promise(Never, Void)) = (event : Html.Event) : Promise(Never, Void) { Promise.never() }

  property onChange : Function(String, Promise(Never, Void)) = (value : String) : Promise(Never, Void) { Promise.never() }
  property onInput : Function(String, Promise(Never, Void)) = (value : String) : Promise(Never, Void) { Promise.never() }

  property onTabOut : Function(Promise(Never, Void)) = Promise.never
  property onFocus : Function(Promise(Never, Void)) = Promise.never
  property onTabIn : Function(Promise(Never, Void)) = Promise.never
  property onClear : Function(Promise(Never, Void)) = Promise.never
  property onBlur : Function(Promise(Never, Void)) = Promise.never

  use Providers.TabFocus {
    onTabIn =
      (element : Dom.Element) : Promise(Never, Void) {
        if (`#{element} === #{input}`) {
          onTabIn()
        } else {
          next {  }
        }
      },
    onTabOut =
      (element : Dom.Element) : Promise(Never, Void) {
        if (`#{element} === #{input}`) {
          onTabOut()
        } else {
          next {  }
        }
      }
  }

  style input {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    background-color: {theme.colors.input.background};
    border: 2px solid {theme.border.color};
    border-radius: {theme.border.radius};
    color: {theme.colors.input.text};
    font-family: {theme.fontFamily};

    line-height: 16px;
    font-size: 16px;

    outline: none;
    height: 38px;
    width: 100%;

    padding: 7px 10px;
    padding-right: {paddingRight};

    &:disabled {
      filter: saturate(0) brightness(0.8);
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
      user-select: none;
      opacity: 0.5;
    }

    &:focus {
      border-color: {theme.colors.primary.background};
    }
  }

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    display: inline-block;
    position: relative;
    width: 100%;
  }

  style icon {
    fill: {theme.colors.input.text};
    position: absolute;
    cursor: pointer;
    height: 12px;
    width: 12px;
    right: 13px;
    top: 13px;

    &:hover {
      fill: {theme.hover.color};
    }
  }

  get showCloseIcon : Bool {
    showClearIcon && value != "" && !disabled && !readonly
  }

  get paddingRight : String {
    if (showCloseIcon) {
      "34px"
    } else {
      "9px"
    }
  }

  get closeIcon : Html {
    if (showCloseIcon) {
      <svg::icon
        onClick={(event : Html.Event) : a { onClear() }}
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

  fun focus : Promise(Never, Void) {
    Dom.focusWhenVisible(input)
  }

  fun handleChange (event : Html.Event) : Promise(Never, Void) {
    onChange(Dom.getValue(event.target))
  }

  fun handleInput (event : Html.Event) : Promise(Never, Void) {
    onInput(Dom.getValue(event.target))
  }

  fun render : Html {
    <div::base>
      <input::input as input
        onChange={handleChange}
        onInput={handleInput}
        onFocus={onFocus}
        onBlur={onBlur}
        onMouseDown={onMouseDown}
        onMouseUp={onMouseUp}
        onKeyDown={onKeyDown}
        onKeyUp={onKeyUp}
        placeholder={placeholder}
        disabled={disabled}
        readOnly={readonly}
        value={value}
        type={type}/>

      <{ closeIcon }>
    </div>
  }
}
