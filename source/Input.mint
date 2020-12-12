/* A component for getting user input. */
component Ui.Input {
  /* The event handler for the icons click event. */
  property onIconClick : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* The `mousedown` event handler. */
  property onMouseDown : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* The `mouseup` event handler. */
  property onMouseUp : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* The `change` event handler. */
  property onChange : Function(String, Promise(Never, Void)) = Promise.never1

  /* The `keydown` event handler. */
  property onKeyDown : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* The `keyup` event handler. */
  property onKeyUp : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* The event handler when the user tabs out of the input. */
  property onTabOut : Function(Promise(Never, Void)) = Promise.never

  /* The event handler when the user tabs into the input. */
  property onTabIn : Function(Promise(Never, Void)) = Promise.never

  /* The `focus` event handler. */
  property onFocus : Function(Promise(Never, Void)) = Promise.never

  /* The `blur` event handler. */
  property onBlur : Function(Promise(Never, Void)) = Promise.never

  /* Wether or not the icon is interactive. */
  property iconInteractive : Bool = false

  /* The placeholder to show. */
  property placeholder : String = ""

  /* The number of milliseconds to delay the `onChange` event. */
  property inputDelay : Number = 0

  /* Wether or not the input is disabled. */
  property disabled : Bool = false

  /* Wether or not the input is invalid. */
  property invalid : Bool = false

  /* The type of the input, should be either `text` or `email`. */
  property type : String = "text"

  /* The value of the input. */
  property value : String = ""

  /* The size of the input. */
  property size : Number = 16

  /* The content for the icon. */
  property icon : Html = <></>

  /* The ID of the datalist element to connect to this input. */
  property list : String = ""

  /* The current value of the input. */
  state currentValue : Maybe(String) = Maybe::Nothing

  /* The ID of the last timeout. */
  state timeoutId : Number = 0

  use Providers.TabFocus {
    onTabOut = onTabOut,
    onTabIn = onTabIn,
    element = input
  }

  /* The styles for the input. */
  style input {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    box-sizing: border-box;

    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    background-color: var(--content-color);
    color: var(--content-text);

    font-family: var(--font-family);
    font-size: inherit;

    padding: 0.4375em 0.625em;
    line-height: 1em;
    height: 2.375em;

    /* This disables the autofill color. */
    filter: none;

    outline: none;
    width: 100%;

    if (invalid) {
      border: 0.125em solid var(--danger-s500-color);
    } else {
      border: 0.125em solid var(--border);
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
        box-shadow: 0 0 0 0.1875em var(--danger-shadow);
        border-color: var(--danger-s300-color);
      } else {
        box-shadow: 0 0 0 0.1875em var(--primary-shadow);
        border-color: var(--primary-s500-color);
      }
    }
  }

  /* The styles for the base. */
  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    font-size: #{size}px;

    display: inline-block;
    position: relative;
    width: 100%;
  }

  /* The styles for the icon. */
  style icon {
    right: 0.6875em;
    top: 0.6875em;

    height: 1em;
    width: 1em;

    color: var(--content-text);
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
      color: var(--primary-s500-color);
    }
  }

  /* Wether to show the icon or not. */
  get showIcon : Bool {
    Html.isNotEmpty(icon)
  }

  /* Focuses the input. */
  fun focus : Promise(Never, Void) {
    Dom.focus(input)
  }

  /* Handles the `input` and `change` events. */
  fun handleChange (event : Html.Event) {
    try {
      {nextId, nextValue, promise} =
        Ui.InputDelay.handle(timeoutId, inputDelay, event)

      next
        {
          currentValue = Maybe::Just(nextValue),
          timeoutId = nextId
        }

      sequence {
        /* Await the promise here. */
        promise

        actualValue =
          Maybe.withDefault(value, currentValue)

        next { currentValue = Maybe::Nothing }

        onChange(actualValue)
      }
    }
  }

  /* Renders the input. */
  fun render : Html {
    <div::base>
      <input::input as input
        onMouseDown={onMouseDown}
        onChange={handleChange}
        onInput={handleChange}
        onMouseUp={onMouseUp}
        onKeyDown={onKeyDown}
        onFocus={onFocus}
        onKeyUp={onKeyUp}
        onBlur={onBlur}
        value={Maybe.withDefault(value, currentValue)}
        placeholder={placeholder}
        disabled={disabled}
        list={list}
        type={type}/>

      if (showIcon) {
        <div::icon onClick={onIconClick}>
          <Ui.Icon
            autoSize={true}
            icon={icon}/>
        </div>
      }
    </div>
  }
}
