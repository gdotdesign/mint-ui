/*
A dropdown component, which renders the given content around the given
element using the given position.
*/
component Ui.Dropdown {
  connect Ui exposing { mobile }

  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  /* The close event handler. */
  property onClose : Function(Promise(Never, Void)) = Promise.never

  /* Wether or not to trigger the close event when clicking outside of the panel. */
  property closeOnOutsideClick : Bool = false

  /* Wether or not to make the dropdown the same width as the element. */
  property fullWidth : Bool = false

  /* The position of the panel. */
  property position : String = "bottom-left"

  /* The element which trigger the dropdown. */
  property element : Html = <{  }>

  /* The content to show in the dropdown. */
  property content : Html = <{  }>

  /* The offset from the side of the element. */
  property offset : Number = 0

  /* The zIndex to use for the dropdown. */
  property zIndex : Number = 1

  /* Wether or not the dropdown is open. */
  property open : Bool = false

  /* The width of the panel if `fullWidth` is true. */
  state width : Number = 0

  use Provider.Mouse {
    clicks = Promise.Extra.never1,
    moves = Promise.Extra.never1,
    ups = close
  } when {
    open
  }

  use Provider.AnimationFrame {
    frames = updateDimensions
  } when {
    open
  }

  /* Style for the panel. */
  style panel {
    if (fullWidth) {
      width: #{width}px;
    }

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

  /* Updates the dimensions of the panel if `fullWidth` is true. */
  fun updateDimensions : Promise(Never, Void) {
    case (stickyPanel) {
      Maybe::Just panel =>
        try {
          rect =
            Dom.getDimensions(`#{panel}.base`)

          next { width = rect.width }
        }

      Maybe::Nothing => next {  }
    }
  }

  /* The close event handler. */
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

  /* Renders the dropdown. */
  fun render : Html {
    if (mobile) {
      <>
        <{ element }>

        <Html.Portals.Body>
          <Ui.Modal.Base
            closeOnOutsideClick={closeOnOutsideClick}
            onClose={onClose}
            content={content}
            open={open}/>
        </Html.Portals.Body>
      </>
    } else {
      <Ui.StickyPanel as stickyPanel
        shouldCalculate={open}
        passThrough={!open}
        position={position}
        element={element}
        offset={offset}
        zIndex={zIndex}
        content={
          <div::panel as panel onClick={onClick}>
            <{ content }>
          </div>
        }/>
    }
  }
}
