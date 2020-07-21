/* A vertical list the user can interact with using the keyboard. */
component Ui.InteractiveList {
  property items : Array(Ui.ListItem) = []

  /* The select event handler. */
  property onSelect : Function(String, Promise(Never, Void)) = (key : String) { next {  } }

  /* The selected set of items. */
  property selected : Set(String) = Set.empty()

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
      40 =>
        try {
          Html.Event.preventDefault(event)
          selectNext(true)
        }

      38 =>
        try {
          Html.Event.preventDefault(event)
          selectNext(false)
        }

      13 => onSelect(intended)

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
                Ui.ListItem::Divider => <></>

                Ui.ListItem::Item key content =>
                  <Ui.List.Item
                    onClick={(event : Html.Event) { handleSelect(key) }}
                    intended={intendable && key == intended}
                    selected={Set.has(key, selected)}
                    size={size}
                    key={key}>

                    <{ content }>

                  </Ui.List.Item>
              }
            }
          </div>
        </Ui.ScrollPanel>

      </div>
    }
  }
}
