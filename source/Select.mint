component Ui.Select {
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
    border-radius: 4px;
    border: 2px solid;

    background: #FFF;
    color: #666;

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
      filter: "saturate(0) brightness(0.8)";
      cursor: not-allowed;
    } else {
      cursor: pointer;
    }

    if (open) {
      border-color: #3B7DFF;
    } else {
      border-color: #E9E9E9;
    }

    &:focus {
      border-color: #3B7DFF;
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
    sequence {
      Maybe.map(Dom.focusWhenVisible, element)
      next {  }
    }
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
      onSelect={onChange}
      selected={value}
      items={items}
      element={
        <div::element as element
          tabindex={tabindex}
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
