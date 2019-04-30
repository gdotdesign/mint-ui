component Ui.Pager.Page {
  property transitioning : Bool = false
  property transition : String = "slide"
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

component Ui.Pager {
  property pages : Array(Ui.Pager.Item) = []
  property transition : String = "slide"
  property duration : Number = 1000
  property active : String = ""

  state transitioning : Bool = false
  state center : String = ""
  state left : String = ""

  fun componentDidUpdate : Promise(Never, Void) {
    if (center != active && hasPage) {
      if (isPage) {
        switchPages()
      } else {
        next { center = active }
      }
    } else {
      next {  }
    }
  }

  get isPage : Bool {
    Array.any(
      (item : Ui.Pager.Item) : Bool { item.name == center },
      pages)
  }

  get hasPage : Bool {
    Array.any(
      (item : Ui.Pager.Item) : Bool { item.name == active },
      pages)
  }

  fun switchPages : Promise(Never, Void) {
    sequence {
      next
        {
          left = center,
          center = active,
          transitioning = true
        }

      Timer.timeout(duration, "a")

      next
        {
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
      transitioning={isTransitioning}
      transition={transition}
      position={position}
      duration={duration}>

      <{ item.contents }>

    </Ui.Pager.Page>
  } where {
    isTransitioning =
      (left == item.name || center == item.name) && transitioning

    position =
      if (left == item.name) {
        -100
      } else if (center == item.name) {
        0
      } else {
        100
      }
  }

  fun render : Html {
    <div::base>
      <{ Array.map(renderPage, pages) }>
    </div>
  }
}
