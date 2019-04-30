record Provider.TabFocus.Subscription {
  onTabIn : Function(Dom.Element, a),
  onTabOut : Function(Dom.Element, a)
}

provider Providers.TabFocus : Provider.TabFocus.Subscription {
  fun handleKeyUp (event : Html.Event) : Promise(Never, Void) {
    `
    (() => {
      if (#{event.keyCode} == 9) {
        for (let subscription of this.subscriptions) {
          subscription[1].onTabIn(document.activeElement)
        }
      }
    })()
    `
  }

  fun handleKeyDown (event : Html.Event) : Promise(Never, Void) {
    `
    (() => {
      if (#{event.keyCode} == 9) {
        for (let subscription of this.subscriptions) {
          subscription[1].onTabOut(#{event.target})
        }
      }
    })()
    `
  }

  fun attach : Void {
    `
    (() => {
      this.keyUp || (this.keyUp = ((event) => #{handleKeyUp}(_normalizeEvent(event))))
      this.keyDown || (this.keyDown = ((event) => #{handleKeyDown}(_normalizeEvent(event))))

      window.addEventListener("keyup", this.keyUp, true)
      window.addEventListener("keydown", this.keyDown, true)
    })()
    `
  }

  fun detach : Void {
    `
    (() => {
      window.removeEventListener("keyup", this.keyUp, true)
      window.removeEventListener("keydown", this.keyDown, true)
    })()
    `
  }
}

component Ui.Input {
  connect Ui exposing { theme }

  property placeholder : String = ""
  property type : String = "text"
  property value : String = ""

  property showClearIcon : Bool = true
  property disabled : Bool = false
  property readonly : Bool = false

  property onMouseUp : Function(Html.Event, a) = (event : Html.Event) : a { void }
  property onKeyDown : Function(Html.Event, a) = (event : Html.Event) : a { void }
  property onChange : Function(String, a) = (value : String) : a { void }
  property onInput : Function(String, a) = (value : String) : a { void }
  property onFocus : Function(a) = () : Void { void }
  property onClear : Function(a) = () : Void { void }
  property onBlur : Function(a) = () : Void { void }
  property onTabIn : Function(a) = () : Void { void }
  property onTabOut : Function(a) = () : Void { void }

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

  fun render : Html {
    <div::base>
      <input::input as input
        onChange={(event : Html.Event) : a { onChange(Dom.getValue(event.target)) }}
        onInput={(event : Html.Event) : a { onInput(Dom.getValue(event.target)) }}
        onFocus={(event : Html.Event) : a { onFocus() }}
        onBlur={(event : Html.Event) : a { onBlur() }}
        onMouseUp={onMouseUp}
        onKeyDown={onKeyDown}
        placeholder={placeholder}
        disabled={disabled}
        readonly={readonly}
        value={value}
        type={type}/>

      <{ closeIcon }>
    </div>
  }
}
