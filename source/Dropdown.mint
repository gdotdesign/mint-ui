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

  use Provider.Mouse {
    clicks = \event : Html.Event => void,
    moves = \data : Html.Event => void,
    ups = \data : Html.Event => void
  } when {
    open
  }

  use Provider.AnimationFrame {
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
      Dom.getElementById(state.uid)
      |> Maybe.withDefault(Dom.createElement("div"))

    width =
      Window.width()

    height =
      Window.height()

    panelDimensions =
      Dom.getDimensions(dom)

    dimensions =
      `ReactDOM.findDOMNode(this)`
      |> Dom.getDimensions()

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
      <Html.Portals.Body>
        <{ panel }>
      </Html.Portals.Body>
    } else {
      Html.empty()
    }
  }

  fun render : Array(Html) {
    [
      element,
      panelPortal
    ]
  }
}
