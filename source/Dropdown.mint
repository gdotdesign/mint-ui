record Ui.Dropdown.State {
  left : Number,
  top : Number,
  uid : String
}

component Ui.Dropdown {
  property element : Html = Html.empty()
  property children : Array(Html) = []
  property open : Bool = true

  style panel {
    position: fixed;
    left: {state.left}px;
    top: {state.top}px;
  }

  state : Ui.Dropdown.State {
    uid = Uid.generate(),
    left = 0,
    top = 0
  }

  use MouseProvider {
    moves = \data : MouseProvider.Position => void,
    ups = \data : Html.Event => void,
    clicks = \event : Html.Event => void
  } when {
    open
  }

  use AnimationFrameProvider {
    frames = updateDimensions
  } when {
    open
  }

  fun updateDimensions : Void {
    next
      { state |
        top = top,
        left = left
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
      dimensions.top + dimensions.height

    left =
      dimensions.left
  }

  get panel : Html {
    <div::panel id={state.uid}>
      <{ children }>
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
