component Ui.Dropdown.Panel {
  connect Ui exposing { contentBackground, contentText, borderColor, borderRadiusCoefficient }
  property children : Array(Html) = []
  property width : String = "auto"

  style base {
    box-shadow: 0 2px 10px -2px rgba(0,0,0,0.1);
    border-radius: #{12.121212 * borderRadiusCoefficient}px;
    width: #{width};
    border: 1px solid #{borderColor};
    padding: 16px;

    background: #{contentBackground};
    color: #{contentText};
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

component Ui.Dropdown {
  property onClose : Function(Promise(Never, Void)) = Promise.never

  property closeOnOutsideClick : Bool = false
  property position : String = "bottom-left"
  property element : Html = Html.empty()
  property content : Html = Html.empty()
  property offset : Number = 0
  property zIndex : Number = 1
  property open : Bool = false

  use Provider.Mouse {
    clicks = (event : Html.Event) : Promise(Never, Void) { next {  } },
    moves = (event : Html.Event) : Promise(Never, Void) { next {  } },
    ups = close
  } when {
    open
  }

  style panel {
    if (open) {
      transition: transform 150ms 0ms ease,
                  visibility 1ms 0ms ease,
                  opacity 150ms 0ms ease;

      transform: translateY(0);
      opacity: 1;
    } else {
      transition: visibility 1ms 150ms ease,
                  transform 150ms 0ms ease,
                  opacity 150ms 0ms ease;

      transform: translateY(20px);
      visibility: hidden;
      opacity: 0;
    }
  }

  fun close (event : Html.Event) : Promise(Never, Void) {
    if (closeOnOutsideClick) {
      case (panel) {
        Maybe::Just element =>
          if (Dom.contains(event.target, element)) {
            next {  }
          } else {
            onClose()
          }

        Maybe::Nothing => next {  }
      }
    } else {
      next {  }
    }
  }

  fun render : Html {
    <Ui.StickyPanel
      shouldCalculate={open}
      passThrough={!open}
      position={position}
      element={element}
      offset={offset}
      zIndex={zIndex}
      content={
        <div::panel as panel>
          <{ content }>
        </div>
      }/>
  }
}
