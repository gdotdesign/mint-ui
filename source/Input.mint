component Ui.Input {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  property placeholder : String = ""
  property inputDelay : Number = 0
  property disabled : Bool = false
  property invalid : Bool = false
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

    border-radius: #{1.5625 * actualTheme.borderRadiusCoefficient}em;
    background-color: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    font-family: #{actualTheme.fontFamily};
    font-size: inherit;

    padding: 0.4375em 0.625em;
    line-height: 1em;
    height: 2.375em;

    /* This disables the autofill color. */
    filter: none;

    outline: none;
    width: 100%;

    if (invalid) {
      border: 0.125em solid #{actualTheme.danger.s500.color};
    } else {
      border: 0.125em solid #{actualTheme.border};
    }

    if (showIcon) {
      padding-right: 2.125em;
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    }

    &:focus {
      if (invalid) {
        box-shadow: 0 0 0 0.1875em #{actualTheme.danger.shadow};
        border-color: #{actualTheme.danger.s300.color};
      } else {
        box-shadow: 0 0 0 0.1875em #{actualTheme.primary.shadow};
        border-color: #{actualTheme.primary.s500.color};
      }
    }
  }

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    font-size: #{size}px;

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
    display: grid;

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
            autoSize={true}/>
        </div>
      }
    </div>
  }
}
