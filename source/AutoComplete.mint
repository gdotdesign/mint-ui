enum Ui.AutoComplete.Status {
  Searching(String, Number, Array(Ui.AutoComplete.Item))
  Closed(String, Number, Array(Ui.AutoComplete.Item))
}

record Ui.AutoComplete.Item {
  matchString : String,
  content : Html,
  key : String
}

component Ui.AutoComplete {
  connect Ui exposing { theme }

  property onClose : Function(Promise(Never, Void)) = Promise.never
  property onTabOut : Function(Promise(Never, Void)) = Promise.never

  property onSelect : Function(String, Promise(Never, Void)) =
    (selected : String) : Promise(Never, Void) { Promise.never() }

  property items : Array(Ui.AutoComplete.Item) = []
  property position : String = "bottom-right"

  property showClearSelection : Bool = false
  property animateScroll : Bool = true
  property closeOnSelect : Bool = true
  property closeOnTabOut : Bool = true

  property placeholder : String = ""
  property selected : String = ""
  property label : String = ""

  property emptyMessage : Html = <></>
  property element : Html = <></>

  state status : Ui.AutoComplete.Status = Ui.AutoComplete.Status::Closed("", 0, [])

  style select {
    border: 1px solid #e5e5e5;
    height: 40px;
    vertical-align: middle;
    display: inline-block;
    line-height: 38px;
    padding: 0 10px;

    background: #fff;
    color: #666;
  }

  style empty {
    font-family: #{theme.fontFamily};
    font-style: italic;
    padding: 10px;
    opacity: 0.75;
  }

  style clear {
    color: #{theme.colors.primary.background};
    font-family: #{theme.fontFamily};
    text-transform: uppercase;
    display: block;
    cursor: pointer;
    font-size: 12px;
    margin-top: 10px;
  }

  get open : Bool {
    case (status) {
      Ui.AutoComplete.Status::Searching => true
      Ui.AutoComplete.Status::Closed => false
    }
  }

  fun componentDidMount : Promise(Never, Void) {
    next { status = Ui.AutoComplete.Status::Closed("", 0, items) }
  }

  /* Handles the events from the input and filters the items. */
  fun handleInput (search : String) : Promise(Never, Void) {
    try {
      regexp =
        Regexp.createWithOptions(
          search,
          {
            caseInsensitive = true,
            multiline = false,
            unicode = false,
            global = false,
            sticky = false
          })

      filtered =
        for (item of items) {
          item
        } when {
          Regexp.match(item.matchString, regexp)
        }

      next { status = Ui.AutoComplete.Status::Searching(search, selectedIndex(filtered), filtered) }

      scrollIntoView()
    }
  }

  fun selectedIndex (items : Array(Ui.AutoComplete.Item)) : Number {
    try {
      items
      |> Array.find(
        (item : Ui.AutoComplete.Item) : Bool { item.key == selected })
      |> Maybe.map(
        (item : Ui.AutoComplete.Item) : Number {
          Array.indexBy(
            selected,
            (item : Ui.AutoComplete.Item) : String { item.key },
            items)
        })
      |> Maybe.withDefault(0)
    }
  }

  fun hide : Promise(Never, Void) {
    sequence {
      next
        {
          status =
            case (status) {
              Ui.AutoComplete.Status::Searching a b c => Ui.AutoComplete.Status::Closed(a, b, c)
              => status
            }
        }

      onClose()
    }
  }

  fun select (index : Number, key : String) : Promise(Never, Void) {
    sequence {
      onSelect(key)

      nextStatus =
        case (status) {
          Ui.AutoComplete.Status::Searching search selected items => Ui.AutoComplete.Status::Searching(search, index, items)
          => status
        }

      next { status = nextStatus }

      if (closeOnSelect) {
        hide()
      } else {
        next {  }
      }
    }
  }

  fun handleKeyDown (event : Html.Event) : Promise(Never, Void) {
    case (status) {
      Ui.AutoComplete.Status::Searching search index items =>
        case (event.keyCode) {
          27 => hide()

          13 =>
            items[index]
            |> Maybe.map(.key)
            |> Maybe.withDefault("")
            |> select(index)

          40 =>
            try {
              Html.Event.preventDefault(event)

              nextIndex =
                if (index == Array.size(items) - 1) {
                  0
                } else {
                  index + 1
                }

              next { status = Ui.AutoComplete.Status::Searching(search, nextIndex, items) }
              scrollIntoView()
            }

          38 =>
            try {
              Html.Event.preventDefault(event)

              nextIndex =
                if (index == 0) {
                  Array.size(items) - 1
                } else {
                  index - 1
                }

              next { status = Ui.AutoComplete.Status::Searching(search, nextIndex, items) }
              scrollIntoView()
            }

          => next {  }
        }

      => next {  }
    }
  }

  fun show : Promise(Never, Void) {
    sequence {
      next { status = Ui.AutoComplete.Status::Searching("", selectedIndex(items), items) }
      scrollIntoView()
      input&.focus&()
      next {  }
    }
  }

  fun scrollIntoView : Promise(Never, Void) {
    sequence {
      Timer.nextFrame("")

      `
      (() => {
        const element = #{base}._0.querySelector('[data-selected=true]')
        element && scrollIntoViewIfNeeded(element, true)
      })()
      `
    }
  }

  fun renderItems (
    value : String,
    selected : Number,
    items : Array(Ui.AutoComplete.Item)
  ) : Array(Html) {
    if (Array.isEmpty(items)) {
      [
        <div::empty>
          <{ emptyMessage }>
        </div>
      ]
    } else {
      items
      |> Array.mapWithIndex(
        (item : Ui.AutoComplete.Item, index : Number) : Html {
          <Ui.List.Item
            onClick={(event : Html.Event) : Promise(Never, Void) { select(index, item.key) }}
            selected={selected == index}
            key={item.key}
            selectable={true}>

            <{ item.content }>

          </Ui.List.Item>
        })
    }
  }

  fun handleTabOut : Promise(Never, Void) {
    sequence {
      onTabOut()

      if (closeOnTabOut) {
        hide()
      } else {
        next {  }
      }
    }
  }

  fun render : Html {
    <Ui.Dropdown
      position={position}
      element={element}
      onClose={hide}
      zIndex={1000}
      open={open}
      offset={5}
      content={
        <Ui.Dropdown.Panel>
          <div as base>
            <Ui.Input as input
              onTabOut={handleTabOut}
              placeholder={placeholder}
              onKeyDown={handleKeyDown}
              onChange={handleInput}
              showClearIcon={false}
              value={
                case (status) {
                  Ui.AutoComplete.Status::Searching search => search
                  Ui.AutoComplete.Status::Closed search => search
                }
              }/>

            <Ui.Spacer height={10}/>

            <Ui.ScrollPanel animateScroll={animateScroll}>
              <Ui.List>
                case (status) {
                  Ui.AutoComplete.Status::Searching value selected items => renderItems(value, selected, items)
                  Ui.AutoComplete.Status::Closed value selected items => renderItems(value, selected, items)
                }
              </Ui.List>
            </Ui.ScrollPanel>

            if (showClearSelection) {
              <a::clear onClick={() : Promise(Never, Void) { select(-1, "") }}>
                "x Clear selection."
              </a>
            } else {
              <></>
            }
          </div>
        </Ui.Dropdown.Panel>
      }/>
  }
}
