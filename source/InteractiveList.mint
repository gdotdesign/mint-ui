/* A vertical list the user can interact with using the keyboard. */
component Ui.InteractiveList {
  /* The select event handler (when an item is clicked). */
  property onClickSelect : Function(String, Promise(Never, Void)) = Promise.never1

  /* The select event handler. */
  property onSelect : Function(String, Promise(Never, Void)) = Promise.never1

  /* The selected set of items. */
  property selected : Set(String) = Set.empty()

  /* The items to render. */
  property items : Array(Ui.ListItem) = []

  /* Wether or not the list is interactive. */
  property interactive : Bool = true

  /* Wether or not the user can intend to select an element. */
  property intendable : Bool = false

  /* The size of the list. */
  property size : Number = 16

  /* The current intended element. */
  state intended : String = ""

  /* The styles for the base. */
  style base {
    font-size: #{size}px;
    outline: none;

    if (interactive) {
      padding: 0.125em;
    }

    &:focus {
      if (interactive) {
        box-shadow: 0 0 0 0.125em var(--primary-s500-color),
                    0 0 0 0.1875em var(--primary-shadow);
      }
    }
  }

  /* The styles for the items. */
  style items {
    grid-gap: 0.3125em;
    display: grid;
  }

  /* Intend the first element when the component is mounted. */
  fun componentDidMount {
    next
      {
        intended =
          selected
          |> Set.toArray
          |> Array.first
          |> Maybe.withDefault("")
      }
  }

  /* Sets the intended element. */
  fun intend (value : String) {
    next { intended = value }
  }

  /* Handles a select event. */
  fun handleSelect (value : String) {
    sequence {
      intend(value)
      onSelect(value)
    }
  }

  /* Handles a select event (when the item is clicked). */
  fun handleClickSelect (value : String) {
    sequence {
      intend(value)
      onClickSelect(value)
    }
  }

  /* Selects the next or previous element. */
  fun selectNext (forward : Bool) {
    try {
      index =
        Array.indexBy(intended, Ui.ListItem.key, items)

      nextIndex =
        if (forward) {
          if (index == Array.size(items) - 1) {
            0
          } else {
            index + 1
          }
        } else if (index == 0) {
          Array.size(items) - 1
        } else {
          index - 1
        }

      nextKey =
        items[nextIndex]
        |> Maybe.map(Ui.ListItem.key)
        |> Maybe.withDefault("")

      if (intendable) {
        intend(nextKey)
      } else {
        handleSelect(nextKey)
      }

      case (container) {
        Maybe::Just element => `scrollIntoViewIfNeeded(#{element}.children[#{nextIndex}])`
        => Dom.createElement("div")
      }
    }
  }

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    case (event.keyCode) {
      Html.Event:ENTER => onSelect(intended)

      Html.Event:SPACE =>
        try {
          Html.Event.preventDefault(event)
          onSelect(intended)
        }

      Html.Event:DOWN_ARROW =>
        try {
          Html.Event.preventDefault(event)
          selectNext(true)
        }

      Html.Event:UP_ARROW =>
        try {
          Html.Event.preventDefault(event)
          selectNext(false)
        }

      => next {  }
    }
  }

  /* Renders the list. */
  fun render : Html {
    try {
      tabIndex =
        if (interactive) {
          "0"
        } else {
          "-1"
        }

      <div::base
        onKeyDown={Ui.disabledHandler(!interactive, handleKeyDown)}
        tabindex={tabIndex}>

        <Ui.ScrollPanel>
          <div::items as container>
            for (item of items) {
              case (item) {
                Ui.ListItem::Item key content =>
                  <Ui.List.Item
                    onClick={(event : Html.Event) { handleClickSelect(key) }}
                    intended={intendable && key == intended}
                    selected={Set.has(key, selected)}
                    size={size}
                    key={key}>

                    <{ content }>

                  </Ui.List.Item>

                Ui.ListItem::Divider => <></>
              }
            }
          </div>
        </Ui.ScrollPanel>

      </div>
    }
  }
}
