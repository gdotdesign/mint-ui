record Ui.Chooser.State {
  selected : Maybe(String),
  search : String,
  open : Bool
}

component Ui.Chooser.Item {
  property children : Array(Html) = []
  property intended : Bool = false
  property seleted : Bool = false

  style base {
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
    border-radius: 2px;
    padding: 8px 10px;
    padding-right: 30px;
    position: relative;
    cursor: pointer;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

component Ui.Chooser {
  property renderItem : Function(String, Maybe(String), Html) = defaultRenderItem
  property filterItem : Function(String, String, Bool) = defaultFilter

  property items : Array(String) = []
  property position : String = "bottom-left"
  property offset : Number = 5

  fun defaultFilter (item : String, search : String) : Bool {
    String.match(
      String.toLowerCase(search),
      String.toLowerCase(item))
  }

  fun defaultRenderItem (item : String, selected : Maybe(String)) : Html {
    <Ui.Chooser.Item>
      <{ item }>
    </Ui.Chooser.Item>
  }

  state : Ui.Chooser.State {
    selected = Maybe.nothing(),
    open = false,
    search = ""
  }

  get itemContents : Array(Html) {
    items
    |> Array.select(\item : String => filterItem(item, state.search))
    |> Array.map(
      \item : String =>
        <div onMouseDown={\event : Html.Event => select(event, item)}>
          <{ renderItem(item, state.selected) }>
        </div>)
  }

  get panel : Html {
    <Ui.Dropdown.Panel>
      <{ itemContents }>
    </Ui.Dropdown.Panel>
  }

  get input : Html {
    <Ui.Input
      showClearIcon={state.open}
      onChange={onInputChange}
      onFocus={onInputFocus}
      onClear={onInputClear}
      onBlur={onInputBlur}
      value={value}/>
  }

  get value : String {
    if (state.open) {
      state.search
    } else {
      state.selected
      |> Maybe.map(\item : String => item)
      |> Maybe.withDefault("")
    }
  }

  fun select (event : Html.Event, item : String) : Void {
    do {
      next { state | selected = Maybe.just(item) }
    }
  }

  fun onInputFocus : Void {
    next { state | open = true }
  }

  fun onInputBlur : Void {
    next
      { state |
        open = false,
        search = ""
      }
  }

  fun onInputClear : Void {
    next { state | search = "" }
  }

  fun onInputChange (value : String) : Void {
    next { state | search = value }
  }

  fun render : Html {
    <Ui.Dropdown
      position={position}
      element={input}
      offset={5}
      content={panel}
      offset={offset}
      open={state.open}/>
  }
}
