component Ui.Dropdown.Panel {
  property children : Array(Html) = []
  property width : String = "auto"

  style base {
    box-shadow: 0 5px 20px 0 rgba(0,0,0,0.1);
    border: 1px solid #DDD;
    background: #FDFDFD;
    border-radius: 2px;
    width: {width};
    color: #707070;
    padding: 5px;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

component Ui.Dropdown {
  property onClose : Function(Void) = \ => void
  property shouldAutomaticallyClose : Bool = true
  property position : String = "bottom-left"
  property element : Html = Html.empty()
  property content : Html = Html.empty()
  property uid : String = Uid.generate()
  property offset : Number = 0
  property open : Bool = true

  use Provider.Mouse {
    clicks = \event : Html.Event => void,
    moves = \event : Html.Event => void,
    ups = close
  } when {
    open
  }

  style panel {
    transition: {transition};
    visibility: {visibility};
    opacity: {opacity};
  }

  get transition : String {
    if (open) {
      "opacity 150ms 0ms ease, transform 150ms 0ms ease, visibi" \
      "lity 1ms 0ms ease"
    } else {
      "opacity 150ms 0ms ease, transform 150ms 0ms ease, visibi" \
      "lity 1ms 150ms ease"
    }
  }

  get visibility : String {
    if (open) {
      ""
    } else {
      "hidden"
    }
  }

  get opacity : Number {
    if (open) {
      1
    } else {
      0
    }
  }

  fun close (event : Html.Event) : Void {
    if (shouldAutomaticallyClose) {
      if (Dom.matches(selector, event.target)) {
        void
      } else {
        onClose()
      }
    } else {
      void
    }
  } where {
    selector =
      "[id='" + uid + "'], [id='" + uid + "'] *"
  }

  fun render : Html {
    <Ui.StickyPanel
      shouldCalculate={open}
      passThrough={!open}
      position={position}
      offset={offset}
      element={element}
      uid={uid}
      content={
        <div::panel>
          <{ content }>
        </div>
      }/>
  }
}
