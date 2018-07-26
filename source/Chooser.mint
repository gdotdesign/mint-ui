record Ui.Chooser.State {
  search : String,
  width : String,
  open : Bool
}

component Ui.Chooser.Item {
  connect Ui exposing { theme }

  property children : Array(Html) = []
  property intended : Bool = false
  property selected : Bool = false

  style base {
    background: {background};
    color: {color};

    font-family: {theme.fontFamily};
    text-overflow: ellipsis;
    margin-bottom: 2px;
    margin-top: 2px;

    white-space: nowrap;
    border-radius: 2px;
    position: relative;
    overflow: hidden;
    cursor: pointer;

    padding: 8px 10px;
    padding-right: 30px;

    &:hover {
      background: {theme.colors.primary.background};
      color: {theme.colors.primary.text};
    }
  }

  get background : String {
    if (selected) {
      theme.colors.primary.background
    } else {
      ""
    }
  }

  get color : String {
    if (selected) {
      theme.colors.primary.text
    } else {
      ""
    }
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

  property onChange : Function(Maybe(String), Void) = (selected : Maybe(String)) : Void => { void }
  property selected : Maybe(String) = Maybe.nothing()
  property open : Maybe(Bool) = Maybe.nothing()
  property position : String = "bottom-left"
  property items : Array(String) = []
  property offset : Number = 5

  use Provider.AnimationFrame {
    frames = updateWidth
  } when {
    actualOpen
  }

  fun updateWidth : Void {
    next { state | width = Number.toString(dimesions.width) + "px" }
  } where {
    dimesions =
      `ReactDOM.findDOMNode(this).querySelector('input')`
      |> Dom.getDimensions()
  }

  fun defaultFilter (item : String, search : String) : Bool {
    String.match(
      String.toLowerCase(search),
      String.toLowerCase(item))
  }

  fun defaultRenderItem (item : String, selected : Maybe(String)) : Html {
    <Ui.Chooser.Item selected={Maybe.just(item) == selected}>
      <{ item }>
    </Ui.Chooser.Item>
  }

  state : Ui.Chooser.State {
    width = "auto",
    open = false,
    search = ""
  }

  get itemContents : Array(Html) {
    items
    |> Array.select((item : String) : Bool => { filterItem(item, state.search) })
    |> Array.map(
      (item : String) : Void => {
        <div onMouseDown={(event : Html.Event) : Void => { select(event, item) }}>
          <{ renderItem(item, selected) }>
        </div>
      })
  }

  get panel : Html {
    <Ui.Dropdown.Panel width={state.width}>
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
      selected
      |> Maybe.withDefault("")
    }
  }

  get actualOpen : Bool {
    Maybe.withDefault(state.open, open)
  }

  fun select (event : Html.Event, item : String) : Void {
    onChange(Maybe.just(item))
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
      open={actualOpen}/>
  }
}
