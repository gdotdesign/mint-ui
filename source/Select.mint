component Ui.Select {
  connect Ui exposing {
    surfaceBackground,
    borderRadiusCoefficient,
    contentBackground,
    contentText,
    borderColor,
    primaryBackground,
    primaryShadow
  }

  property onChange : Function(String, Promise(Never, Void)) =
    (selected : String) : Promise(Never, Void) { Promise.never() }

  property items : Array(Ui.AutoComplete.Item) = []
  property position : String = "bottom-right"
  property closeOnSelect : Bool = true
  property searchPlaceholder : String = ""
  property showClearSelection : Bool = true
  property placeholder : String = ""
  property value : String = ""
  property minWidth : String = "300px"
  property disabled : Bool = false
  property size : Number = 16

  state open : Bool = false

  use Providers.TabFocus {
    onTabIn =
      (item : Dom.Element) : Promise(Never, Void) {
        if (item == Maybe.withDefault(Dom.createElement("div"), element)) {
          handleFocus()
        } else {
          next {  }
        }
      },
    onTabOut =
      (element : Dom.Element) : Promise(Never, Void) {
        next {  }
      }
  }

  style element {
    border-radius: 4.8px;
    border: 2px solid;

    border-radius: #{size * borderRadiusCoefficient * 1.1875}px;
    border: #{size * 0.125}px solid #{borderColor};
    background-color: #{contentBackground};
    color: #{contentText};

    font-family: sans-serif;
    box-sizing: border-box;
    user-select: none;

    line-height: 20px;
    font-size: 16px;

    height: 38px;
    min-width: #{minWidth};

    padding: 7px 10px;
    padding-right: 35px;

    position: relative;
    outline: none;

    if (disabled) {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    } else {
      cursor: pointer;
    }

    if (open) {
      box-shadow: 0 0 0 #{size * 0.1875}px #{primaryShadow};
      border-color: #{primaryBackground};
    } else {
      border-color: #{borderColor};
    }

    &:focus {
      if (!disabled) {
        box-shadow: 0 0 0 #{size * 0.1875}px #{primaryShadow};
        border-color: #{primaryBackground};
      } else {
        border-color: #{borderColor};
      }
    }
  }

  style placeholder {
    user-select: none;
    opacity: 0.5;
  }

  style chevron {
    position: absolute;
    right: 12px;
    top: 12px;

    fill: #666;
  }

  get placeholderElement : Html {
    <div::placeholder>
      <{ placeholder }>
    </div>
  }

  get label : Html {
    items
    |> Array.find(
      (item : Ui.AutoComplete.Item) : Bool { item.key == value })
    |> Maybe.map(.content)
    |> Maybe.withDefault(placeholderElement)
  }

  fun handleTabOut : Promise(Never, Void) {
    Dom.focus(element)
  }

  fun handleFocus : Promise(Never, Void) {
    if (disabled) {
      next {  }
    } else if (open) {
      sequence {
        autoComplete&.hide&()
        next {  }
      }
    } else {
      sequence {
        Timer.nextFrame("")
        autoComplete&.show&()
        next { open = true }
      }
    }
  }

  fun handleClose : Promise(Never, Void) {
    next { open = false }
  }

  fun handleOpen : Promise(Never, Void) {
    next { open = true }
  }

  fun handleKeyDown (event : Html.Event) : Promise(Never, Void) {
    sequence {
      autoComplete&.handleKeyDown&(event)
      next {  }
    }
  }

  fun handleSelect (value : String) : Promise(Never, Void) {
    sequence {
      onChange(value)
      Dom.focus(element)
    }
  }

  get tabindex : String {
    if (disabled) {
      "-1"
    } else {
      "0"
    }
  }

  fun render : Html {
    <Ui.AutoComplete as autoComplete
      placeholder={searchPlaceholder}
      closeOnSelect={closeOnSelect}
      onClose={handleClose}
      position={position}
      showClearSelection={showClearSelection}
      onTabOut={handleTabOut}
      onSelect={handleSelect}
      selected={value}
      open={open}
      onOpen={handleOpen}
      items={items}
      element={
        <div::element as element
          tabindex={tabindex}
          onKeyDown={handleKeyDown}
          onMouseUp={handleFocus}>

          <{ label }>

          <svg::chevron
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            height="12"
            width="12">

            <path d="M0 7.33l2.829-2.83 9.175 9.339 9.167-9.339 2.829 2.83-11.996 12.17z"/>

          </svg>

        </div>
      }/>
  }
}
