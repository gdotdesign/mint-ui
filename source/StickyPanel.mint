/* A panel that sticks to the given element. */
component Ui.StickyPanel {
  const DUMMY = Dom.createElement("div")

  /* The position of the panel. */
  property position : String = "bottom-left"

  /* A flag that decides if the position should be calculated on animation frames. */
  property shouldCalculate : Bool = true

  /* The element to position against. */
  property element : Html = Html.empty()

  /* The content to position. */
  property content : Html = Html.empty()

  /* The offset of the panel. */
  property offset : Number = 0

  /* If `true`, pointer events will pass through the panel. */
  property passThrough : Bool = false

  /* The `z-index` of the panel. */
  property zIndex : Number = 0

  /* Variable for the left position. */
  state left : Number = 0

  /* Variable for the right position. */
  state top : Number = 0

  use Provider.AnimationFrame {
    frames = updateDimensions
  } when {
    shouldCalculate
  }

  /* Styles for the panel. */
  style panel {
    z-index: #{zIndex};
    position: fixed;
    left: #{left}px;
    top: #{top}px;

    if (passThrough) {
      pointer-events: none;
    }
  }

  /* Returns the inverse position of the current position. */
  get inversePosition : String {
    case (position) {
      "bottom-center" => "top-center"
      "bottom-right" => "top-right"
      "bottom-left" => "top-left"

      "top-center" => "bottom-center"
      "top-right" => "bottom-right"
      "top-left" => "bottom-left"

      "right-center" => "left-center"
      "right-bottom" => "left-bottom"
      "right-top" => "left-top"

      "left-center" => "right-center"
      "left-bottom" => "right-bottom"
      "left-top" => "right-top"

      => position
    }
  }

  /*
  Returns `true` if the dimensions are fully visible in the window.

  TODO: Move to core.
  */
  fun isFullyVisible (dimensions : Dom.Dimensions) : Bool {
    dimensions.top >= 0 &&
      dimensions.left >= 0 &&
      dimensions.right <= Window.width() &&
      dimensions.bottom <= Window.height()
  }

  /* Calculates the position from the dimensions of the panel and element. */
  fun calculatePosition (
    position : String,
    dimensions : Dom.Dimensions,
    panel : Dom.Dimensions
  ) : Dom.Dimensions {
    { panel |
      bottom = top + panel.height,
      right = left + panel.width,
      left = left,
      top = top,
      x = left,
      y = top
    }
  } where {
    top =
      case (position) {
        "bottom-center" => dimensions.bottom + offset
        "bottom-right" => dimensions.bottom + offset
        "bottom-left" => dimensions.bottom + offset

        "top-center" => dimensions.top - panel.height - offset
        "top-right" => dimensions.top - panel.height - offset
        "top-left" => dimensions.top - panel.height - offset

        "right-center" => dimensions.top + (dimensions.height / 2) - (panel.height / 2)
        "right-bottom" => dimensions.bottom - panel.height
        "right-top" => dimensions.top

        "left-center" => dimensions.top + (dimensions.height / 2) - (panel.height / 2)
        "left-bottom" => dimensions.bottom - panel.height
        "left-top" => dimensions.top

        => 0
      }

    left =
      case (position) {
        "bottom-center" => dimensions.left + (dimensions.width / 2) - (panel.width / 2)
        "bottom-right" => dimensions.right - panel.width
        "bottom-left" => dimensions.left

        "top-center" => dimensions.left + (dimensions.width / 2) - (panel.width / 2)
        "top-right" => dimensions.right - panel.width
        "top-left" => dimensions.left

        "right-center" => dimensions.right + offset
        "right-bottom" => dimensions.right + offset
        "right-top" => dimensions.right + offset

        "left-center" => dimensions.left - panel.width - offset
        "left-bottom" => dimensions.left - panel.width - offset
        "left-top" => dimensions.left - panel.width - offset

        => 0
      }
  }

  /* Calculates the position of the panel. */
  fun updateDimensions : Promise(Never, Void) {
    next
      {
        left = finalPosition.left,
        top = finalPosition.top
      }
  } where {
    panelDimensions =
      panel
      |> Maybe.withDefault(DUMMY)
      |> Dom.getDimensions()

    dimensions =
      `this.base`
      |> Dom.getDimensions()

    favoredPosition =
      calculatePosition(position, dimensions, panelDimensions)

    finalPosition =
      if (isFullyVisible(favoredPosition)) {
        favoredPosition
      } else {
        calculatePosition(
          inversePosition,
          dimensions,
          panelDimensions)
      }
  }

  /* Renders the element and the panel. */
  fun render : Array(Html) {
    [
      element,
      <Html.Portals.Body>
        <div::panel as panel>
          <{ content }>
        </div>
      </Html.Portals.Body>
    ]
  }
}
