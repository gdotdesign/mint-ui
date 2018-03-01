component Ui.Pager.Page {
  property transition : String = "slide"
  property transitioning : Bool = false
  property children : Array(Html) = []
  property duration : Number = 1000
  property position : Number = 0

  style base {
    transition: {transitionDuration}ms;
    pointer-events: {pointerEvents};
    transform: {transform};
    position: absolute;
    opacity: {opacity};
    display: grid;
    bottom: 0;
    right: 0;
    left: 0;
    top: 0;
  }

  get pointerEvents : String {
    if (transition == "fade" && opacity == 0) {
      "none"
    } else {
      ""
    }
  }

  get transform : String {
    if (transition == "slide") {
      "translate3d(0,0,0) translateX(" + Number.toString(position) + "%)"
    } else {
      ""
    }
  }

  get opacity : Number {
    if (transition == "fade") {
      1 - Math.abs(position) / 100
    } else {
      1
    }
  }

  get transitionDuration : Number {
    if (transitioning) {
      duration
    } else {
      0
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

record Ui.Pager.Item {
  contents : Html,
  name : String
}

record Ui.Pager.State {
  transitioning : Bool,
  center : String,
  left : String
}

component Ui.Pager {
  property pages : Array(Ui.Pager.Item) = []
  property transition : String = "slide"
  property duration : Number = 1000
  property active : String = ""

  state : Ui.Pager.State {
    transitioning = false,
    left = "",
    center = ""
  }

  fun componentDidUpdate : Void {
    if (state.center != active && hasPage) {
      if (isPage) {
        switch()
      } else {
        next { state | center = active }
      }
    } else {
      void
    }
  }

  get isPage : Bool {
    Array.any(
      \item : Ui.Pager.Item => item.name == state.center,
      pages)
  }

  get hasPage : Bool {
    Array.any(\item : Ui.Pager.Item => item.name == active, pages)
  }

  fun switch : Void {
    do {
      next
        { state |
          left = state.center,
          center = active,
          transitioning = true
        }

      Timer.timeout(duration)

      next
        { state |
          transitioning = false,
          left = ""
        }
    }
  }

  style base {
    position: relative;
    overflow: hidden;
    flex: 1;
  }

  fun renderPage (item : Ui.Pager.Item) : Html {
    <Ui.Pager.Page
      transitioning={transitioning}
      transition={transition}
      position={position}
      duration={duration}>

      <{ item.contents }>

    </Ui.Pager.Page>
  } where {
    transitioning =
      (state.left == item.name || state.center == item.name) && state.transitioning

    position =
      if (state.left == item.name) {
        -100
      } else {
        if (state.center == item.name) {
          0
        } else {
          100
        }
      }
  }

  fun render : Html {
    <div::base>
      <{ Array.map(renderPage, pages) }>
    </div>
  }
}
