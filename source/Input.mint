component Ui.Input {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  property placeholder : String = ""
  property inputDelay : Number = 0
  property disabled : Bool = false
  property type : String = "text"
  property value : String = ""
  property size : Number = 16

  property iconInteractive : Bool = false
  property icon : String = ""

  property onIconClick : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  property onMouseDown : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onMouseUp : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  property onChange : Function(String, Promise(Never, Void)) = Promise.Extra.never1

  property onKeyDown : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onKeyUp : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  property onTabOut : Function(Promise(Never, Void)) = Promise.never
  property onTabIn : Function(Promise(Never, Void)) = Promise.never

  property onFocus : Function(Promise(Never, Void)) = Promise.never
  property onBlur : Function(Promise(Never, Void)) = Promise.never

  state currentValue : Maybe(String) = Maybe::Nothing
  state timeoutId : Number = 0

  use Providers.TabFocus {
    onTabIn =
      (element : Dom.Element) : Promise(Never, Void) {
        if (Maybe::Just(element) == input) {
          onTabIn()
        } else {
          next {  }
        }
      },
    onTabOut =
      (element : Dom.Element) : Promise(Never, Void) {
        if (Maybe::Just(element) == input) {
          onTabOut()
        } else {
          next {  }
        }
      }
  }

  get actualTheme {
    resolveTheme(theme)
  }

  style input {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    box-sizing: border-box;

    border-radius: #{size * actualTheme.borderRadiusCoefficient * 1.1875}px;
    border: 2px solid #{actualTheme.border};
    background-color: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    font-family: #{actualTheme.fontFamily};
    font-size: #{size}px;

    padding: 0.4375em 0.625em;
    line-height: 1em;
    height: 2.375em;

    outline: none;
    width: 100%;

    if (showIcon) {
      padding-right: 2.125em;
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    }

    &:focus {
      box-shadow: 0 0 0 0.1875em #{actualTheme.primary.shadow};
      border-color: #{actualTheme.primary.s500.color};
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
    right: 0.6875em;
    top: 0.6875em;

    height: 1em;
    width: 1em;

    color: #{actualTheme.content.text};
    position: absolute;
    cursor: pointer;

    if (iconInteractive) {
      pointer-events: auto;
      opacity: 1;
    } else {
      pointer-events: none;
      opacity: 0.75;
    }

    &:hover {
      color: #{actualTheme.primary.s500.color};
    }
  }

  get showIcon : Bool {
    !String.isEmpty(icon)
  }

  fun focus : Promise(Never, Void) {
    Dom.focus(input)
  }

  fun handleChange (event : Html.Event) : Promise(Never, Void) {
    sequence {
      nextValue =
        Dom.getValue(event.target)

      `clearTimeout(#{timeoutId})`

      id =
        `setTimeout(#{notify}, #{inputDelay})`

      next
        {
          timeoutId = id,
          currentValue = Maybe::Just(nextValue)
        }
    }
  }

  fun notify : Promise(Never, Void) {
    sequence {
      onChange(Maybe.withDefault(value, currentValue))

      next { currentValue = Maybe::Nothing }
    }
  }

  fun render : Html {
    <div::base>
      <input::input as input
        value={Maybe.withDefault(value, currentValue)}
        onChange={handleChange}
        onInput={handleChange}
        onMouseDown={onMouseDown}
        onMouseUp={onMouseUp}
        onKeyDown={onKeyDown}
        onFocus={onFocus}
        onKeyUp={onKeyUp}
        onBlur={onBlur}
        placeholder={placeholder}
        disabled={disabled}
        type={type}/>

      if (showIcon) {
        <div::icon onClick={onIconClick}>
          <Ui.Icon
            name={icon}
            size={size}/>
        </div>
      }
    </div>
  }
}
