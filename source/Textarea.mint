/* A textarea component. */
component Ui.Textarea {
  connect Ui exposing { resolveTheme }

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /*
  The behavior of the textarea, can be:
    - `resize-horizontal`
    - `resize-vertical`
    - `resize-both`
    - `static`
    - `grow`
  */
  property behavior : String = "resize-both"

  /* The placeholder to display if the value is empty. */
  property placeholder : String = ""

  /* The number of milliseconds to delay the `onChange` event. */
  property inputDelay : Number = 0

  /* Wether or not the textarea is disabled. */
  property disabled : Bool = false

  /* Wether or not the textarea is invalid. */
  property invalid : Bool = false

  /* The value of the textarea. */
  property value : String = ""

  /* The size of the textarea. */
  property size : Number = 16

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

  /* The current value of the input. */
  state currentValue : Maybe(String) = Maybe::Nothing

  /* The ID of the last timeout. */
  state timeoutId : Number = 0

  use Providers.TabFocus {
    onTabOut = onTabOut,
    onTabIn = onTabIn,
    element = textarea
  }

  /* The common styles for the textarea and it's mirror. */
  style common {
    border: 0.125em solid #{actualTheme.border};
    padding: 0.4375em 0.625em;
    box-sizing: border-box;
  }

  /* Styles for the textarea. */
  style textarea {
    border-radius: #{1.5625 * actualTheme.borderRadiusCoefficient}em;
    background-color: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    font-family: inherit;
    line-height: inherit;
    font-weight: inherit;
    font-size: inherit;
    color: inherit;
    outline: none;
    margin: 0;

    if (invalid) {
      border-color: #{actualTheme.danger.s500.color};
    } else {
      border-color: #{actualTheme.border};
    }

    case (behavior) {
      "grow" =>
        position: absolute;
        overflow: hidden;
        height: 100%;
        width: 100%;
        left: 0;
        top: 0;

      =>
    }

    case (behavior) {
      "resize-horizontal" => resize: horizontal;
      "resize-vertical" => resize: vertical;
      "resize-both" => resize: both;
      => resize: none;
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

  /* Styles for the mirror. */
  style mirror {
    word-break: break-word;
    word-wrap: break-word;
    white-space: pre-wrap;
    visibility: hidden;
    user-select: none;
    display: block;
  }

  /* Styles for the base. */
  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    font-family: #{actualTheme.fontFamily};
    font-size: #{size}px;

    min-height: 2.375em;
    line-height: 1.3em;

    word-break: break-word;
    word-wrap: break-word;
    position: relative;
    overflow: visible;

    display: inline-grid;
    position: relative;
    width: 100%;
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Focuses the textarea. */
  fun focus : Promise(Never, Void) {
    Dom.focus(textarea)
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

        onChange(Maybe.withDefault(value, currentValue))

        next { currentValue = Maybe::Nothing }
      }
    }
  }

  /* Renders the textarea. */
  fun render : Html {
    <div::base>
      case (behavior) {
        "grow" =>
          <div::common::mirror>
            try {
              /* Get the value as lines. */
              lines =
                currentValue
                |> Maybe.withDefault(value)
                |> String.split("\n")

              /*
              We need to add an extra line because the mirror
              won't grow in an empty line.
              */
              last =
                Array.last(lines)
                |> Maybe.map(
                  (item : String) {
                    if (String.isEmpty(item)) {
                      <>
                        " "
                      </>
                    } else {
                      <></>
                    }
                  })
                |> Maybe.withDefault(<></>)

              /* Map lines into spans spearated by line breaks. */
              spans =
                lines
                |> Array.map(
                  (line : String) : Html {
                    <span>
                      <{ line }>
                    </span>
                  })
                |> Array.intersperse(<br/>)

              <>
                <{ spans }>
                <{ last }>
              </>
            }
          </div>

        => <></>
      }

      <textarea::common::textarea as textarea
        onChange={handleChange}
        onInput={handleChange}
        onMouseDown={onMouseDown}
        onMouseUp={onMouseUp}
        onKeyDown={onKeyDown}
        onFocus={onFocus}
        onKeyUp={onKeyUp}
        onBlur={onBlur}
        value={Maybe.withDefault(value, currentValue)}
        placeholder={placeholder}
        disabled={disabled}/>
    </div>
  }
}
