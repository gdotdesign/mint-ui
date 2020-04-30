component Ui.Input {
  connect Ui exposing {
    borderRadiusCoefficient,
    primaryBackground,
    primaryShadow,
    contentBackground,
    contentText,
    surfaceBackground,
    fontFamily
  }

  property placeholder : String = "Placeholder..."
  property type : String = "text"
  property value : String = ""
  property iconInteractive : Bool = false
  property icon : String = ""
  property disabled : Bool = false
  property inputDelay : Number = 0
  property size : Number = 16

  property onIconClick : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onMouseDown : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onMouseUp : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onKeyDown : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onKeyUp : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onChange : Function(String, Promise(Never, Void)) = Promise.Extra.never1
  property onTabOut : Function(Promise(Never, Void)) = Promise.never
  property onFocus : Function(Promise(Never, Void)) = Promise.never
  property onTabIn : Function(Promise(Never, Void)) = Promise.never
  property onClear : Function(Promise(Never, Void)) = Promise.never
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

  style input {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    box-sizing: border-box;

    border-radius: #{size * borderRadiusCoefficient * 1.1875}px;
    border: #{size * 0.125}px solid #{surfaceBackground};
    background-color: #{contentBackground};
    color: #{contentText};

    font-family: #{fontFamily};

    line-height: #{size}px;
    font-size: #{size}px;

    padding: #{size * 0.4375}px #{size * 0.625}px;
    height: #{size * 2.375}px;

    outline: none;
    width: 100%;

    if (showIcon) {
      padding-right: #{size * 2.125}px;
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    }

    &:focus {
      box-shadow: 0 0 0 #{size * 0.1875}px #{primaryShadow};
      border-color: #{primaryBackground};
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
    right: #{size * 0.6875}px;
    top: #{size * 0.6875}px;

    height: #{size}px;
    width: #{size}px;

    color: #{contentText};
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
      color: #{primaryBackground};
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
      Debug.log("WTF")
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
