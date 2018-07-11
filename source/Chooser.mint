record Ui.Chooser.Item {
  content : Html,
  value : String,
  id : String
}

record Ui.Chooser.State {
  selected : Maybe(Ui.Chooser.Item),
  search : String,
  open : Bool
}

component Ui.Chooser {
  property items : Array(Ui.Chooser.Item) = []
  property position : String = "bottom-left"
  property offset : Number = 0

  state : Ui.Chooser.State {
    selected = Maybe.nothing(),
    open = false,
    search = ""
  }

  get itemContents : Array(Html) {
    items
    |> Array.select(
      \item : Ui.Chooser.Item =>
        String.match(
          String.toLowerCase(state.search),
          String.toLowerCase(item.value)))
    |> Array.map(
      \item : Ui.Chooser.Item =>
        <div onMouseDown={\event : Html.Event => select(event, item)}>
          <{ item.content }>
        </div>)
  }

  get panel : Html {
    <div>
      <{ itemContents }>
    </div>
  }

  get input : Html {
    <Ui.Input
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
      |> Maybe.map(\item : Ui.Chooser.Item => item.value)
      |> Maybe.withDefault("")
    }
  }

  fun select (event : Html.Event, item : Ui.Chooser.Item) : Void {
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
    if (state.open) {
      next { state | search = "" }
    } else {
      next { state | selected = Maybe.nothing() }
    }
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
