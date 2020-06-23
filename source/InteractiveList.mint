enum Ui.ListItems {
  Item(Ui.ListItem)
}

record Ui.ListItem {
  matchString : String,
  content : Html,
  key : String
}

component Ui.InteractiveList {
  property items : Array(Ui.ListItem) = []

  property onSelect : Function(String, Promise(Never, Void)) = (key : String) { next {  } }
  property selected : Set(String) = Set.empty()
  property interactive : Bool = true
  property intendable : Bool = false
  property size : Number = 16

  state intended : String = ""

  style base {
    font-size: 16px;
    outline: none;
  }

  style items {
    grid-gap: 0.3125em;
    display: grid;
  }

  fun intend (value : String) {
    next { intended = value }
  }

  fun handleSelect (value : String) {
    sequence {
      intend(value)
      onSelect(value)
    }
  }

  fun handleKeyDown (event : Html.Event) {
    case (event.keyCode) {
      40 =>
        try {
          Html.Event.preventDefault(event)

          index =
            Array.indexBy(intended, .key, items)

          nextIndex =
            if (index == Array.size(items) - 1) {
              0
            } else {
              index + 1
            }

          nextKey =
            items[nextIndex]
            |> Maybe.map(.key)
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

      38 =>
        try {
          Html.Event.preventDefault(event)

          index =
            Array.indexBy(intended, .key, items)

          nextIndex =
            if (index == 0) {
              Array.size(items) - 1
            } else {
              index - 1
            }

          nextKey =
            items[nextIndex]
            |> Maybe.map(.key)
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

      13 => onSelect(intended)

      => next {  }
    }
  }

  fun render : Html {
    <div::base
      onKeyDown={Ui.disabledHandler(!interactive, handleKeyDown)}
      tabindex={
        if (interactive) {
          "0"
        } else {
          "-1"
        }
      }>

      <Ui.ScrollPanel>
        <div::items as container>
          for (item of items) {
            <Ui.List.Item
              onClick={(event : Html.Event) { handleSelect(item.key) }}
              selected={Set.has(item.key, selected)}
              intended={intendable && item.key == intended}
              size={size}
              key={item.key}>

              <{ item.content }>

            </Ui.List.Item>
          }
        </div>
      </Ui.ScrollPanel>

    </div>
  }
}
