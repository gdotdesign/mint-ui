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
            Array.indexBy(intended, Ui.ListItem.key, items)

          nextIndex =
            if (index == Array.size(items) - 1) {
              0
            } else {
              index + 1
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

      38 =>
        try {
          Html.Event.preventDefault(event)

          index =
            Array.indexBy(intended, Ui.ListItem.key, items)

          nextIndex =
            if (index == 0) {
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
