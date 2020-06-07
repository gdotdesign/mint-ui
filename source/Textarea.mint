component Ui.Textarea {
  connect Ui exposing {
    borderRadiusCoefficient,
    primaryBackground,
    primaryShadow,
    contentBackground,
    contentText,
    borderColor,
    fontFamily
  }

  property behavior : String = "resize-both"
  property placeholder : String = ""
  property inputDelay : Number = 0
  property disabled : Bool = false
  property value : String = ""
  property size : Number = 16

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
        if (Maybe::Just(element) == textarea) {
          onTabIn()
        } else {
          next {  }
        }
      },
    onTabOut =
      (element : Dom.Element) : Promise(Never, Void) {
        if (Maybe::Just(element) == textarea) {
          onTabOut()
        } else {
          next {  }
        }
      }
  }

  style common {
    border: #{size * 0.125}px solid #{borderColor};
    padding: #{size * 0.4375}px #{size * 0.625}px;
    box-sizing: border-box;
  }

  style textarea {
    border-radius: #{size * borderRadiusCoefficient * 1.1875}px;
    background-color: #{contentBackground};
    color: #{contentText};

    font-family: inherit;
    line-height: inherit;
    font-weight: inherit;
    font-size: inherit;
    color: inherit;
    outline: none;
    margin: 0;

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
      box-shadow: 0 0 0 #{size * 0.1875}px #{primaryShadow};
      border-color: #{primaryBackground};
    }
  }

  style mirror {
    word-break: break-word;
    word-wrap: break-word;
    white-space: pre-wrap;
    visibility: hidden;
    user-select: none;
    display: block;
  }

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    min-height: #{size * 2.375}px;
    font-family: #{fontFamily};
    line-height: 1.3em;
    font-size: #{size}px;

    word-break: break-word;
    word-wrap: break-word;
    position: relative;
    overflow: visible;

    display: inline-grid;
    position: relative;
    width: 100%;
  }

  fun focus : Promise(Never, Void) {
    Dom.focus(textarea)
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
        disabled={disabled}/>
    </div>
  }
}
