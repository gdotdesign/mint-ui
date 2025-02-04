/*
A dropdown component, which renders the given content around the given
element using the given position.
*/
component Ui.Dropdown {
  connect Ui exposing { mobile }

  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* The close event handler. */
  property onClose : Function(Promise(Never, Void)) = Promise.never

  /* Wether or not to trigger the close event when clicking outside of the panel. */
  property closeOnOutsideClick : Bool = false

  /* Wether or not to make the dropdown the same width as the element. */
  property matchWidth : Bool = false

  /* The position of the panel. */
  property position : String = "bottom-left"

  /* The element which trigger the dropdown. */
  property element : Html = <{  }>

  /* The content to show in the dropdown. */
  property content : Html = <{  }>

  /* The offset from the side of the element. */
  property offset : Number = 5

  /* The zIndex to use for the dropdown. */
  property zIndex : Number = 1

  /* Wether or not the dropdown is open. */
  property open : Bool = false

  /* The width of the panel if `matchWidth` is true. */
  state width : Number = 0

  use Provider.AnimationFrame {
    frames = updateDimensions
  } when {
    open && matchWidth
  }

  use Provider.OutsideClick {
    elements = [panel],
    clicks = onClose
  } when {
    closeOnOutsideClick && open && !mobile
  }

  /* Style for the panel. */
  style panel {
    if (matchWidth) {
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

  /* Updates the dimensions of the panel if `matchWidth` is true. */
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

  /* Renders the dropdown. */
  fun render : Html {
    if (mobile) {
      <>
        <{ element }>

        <Ui.Modal.Base
          closeOnOutsideClick={closeOnOutsideClick}
          onClose={onClose}
          content={content}
          open={open}/>
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
