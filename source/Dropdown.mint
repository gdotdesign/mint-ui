component Ui.Dropdown.Panel {
  property children : Array(Html) = []
  property width : String = "auto"

  style base {
    box-shadow: 0 5px 20px 0 rgba(0,0,0,0.1);
    background: #FDFDFD;
    border-radius: 2px;
    width: #{width};
    color: #707070;
    padding: 10px;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

module Dom.Extra {
  fun contains (element : Dom.Element, base : Dom.Element) : Bool {
    `#{base}.contains(#{element})`
  }
}

component Ui.Dropdown {
  property onClose : Function(Promise(Never, Void)) = Promise.never
  property shouldAutomaticallyClose : Bool = true
  property position : String = "bottom-left"
  property element : Html = Html.empty()
  property content : Html = Html.empty()
  property offset : Number = 0
  property open : Bool = true
  property zIndex : Number = 1

  use Provider.Mouse {
    clicks = (event : Html.Event) : Promise(Never, Void) { next {  } },
    moves = (event : Html.Event) : Promise(Never, Void) { next {  } },
    ups = close
  } when {
    open
  }

  style panel {
    transition: #{transition};
    visibility: #{visibility};
    transform: #{transform};
    opacity: #{opacity};
  }

  get transform : String {
    if (open) {
      "translateY(0)"
    } else {
      "translateY(20px)"
    }
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

  fun close (event : Html.Event) : Promise(Never, Void) {
    panel
    |> Maybe.map(
      (element : Dom.Element) : Promise(Never, Void) {
        if (shouldAutomaticallyClose && Dom.Extra.contains(event.target, element)) {
          next {  }
        } else {
          onClose()
        }
      })
    |> Maybe.withDefault(next {  })
  }

  fun render : Html {
    <Ui.StickyPanel
      shouldCalculate={open}
      passThrough={!open}
      position={position}
      offset={offset}
      element={element}
      zIndex={zIndex}
      content={
        <div::panel as panel>
          <{ content }>
        </div>
      }/>
  }
}
