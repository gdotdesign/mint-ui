record Ui.Dropdown.State {
  left : Number,
  top : Number,
  uid : String,
  open : Bool
}
component Ui.Dropdown {
  property element : Html = Html.empty()
  property open : Bool = true

  style panel {
    position: fixed;
    left: {state.left};
    top: {state.top};
  }

  state : Ui.Dropdown.State {
    top = 0,
    left = 0,
    open = true,
    uid = Uid.generate()
  }

  use MouseProvider {
    moves = \data : MouseProvider.Position => void,
    ups = \data : Html.Event => void,
    clicks = \event : Html.Event => void,
  } when {
    open
  }

  fun componentDidMount : Void {
    updateDimensions()
  }

  fun componentDidUpdate : Void {
    updateDimensions()
  }

  fun updateDimensions : Void {
    do {
      DOM.setStyle("top", top, dom)
      DOM.setStyle("left", left, dom)
    }
  } where {
    dom =
      DOM.getElementById(state.uid)

    width =
      Window.width()

    height =
      Window.height()

    panelDimensions =
      DOM.getDimensions(dom)

    dimensions =
      `ReactDOM.findDOMNode(this)`
      |> DOM.getDimensions()

    top =
      Number.toString(dimensions.top + dimensions.height)

    left =
      Number.toString(dimensions.left)
  }

  get panel : Html {
    <div::panel id={state.uid}>
      <{ "Panel" }>
    </div>
  }

  get panelPortal : Html {
    if (open) {
      <Html.Portals.Body element={panel}/>
    } else {
      Html.empty()
    }
  }

  fun render : Html {
    <Html.Fragment>
      <{ element }>
      <{ panelPortal }>
    </Html.Fragment>
  }
}
