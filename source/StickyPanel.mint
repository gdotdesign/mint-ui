/* A panel that sticks to the given element. */
component Ui.StickyPanel {
  /* The position of the panel. */
  property position : String = "bottom-left"

  /* A flag that decides if the position should be calculated on animation frames. */
  property shouldCalculate : Bool = true

  /* The element to position against. */
  property element : Html = Html.empty()

  /* The content to position. */
  property content : Html = Html.empty()

  /* A unique identifier used to identify the panel. */
  property uid : String = Uid.generate()

  /* The offset of the panel. */
  property offset : Number = 0

  /* If true pointer events pass through the panel. */
  property passThrough : Bool = false

  /* The state is a dimensions object. */
  state : Dom.Dimensions {
    bottom = 0,
    height = 0,
    width = 0,
    right = 0,
    left = 0,
    top = 0,
    x = 0,
    y = 0
  }

  style panel {
    pointer-events: {pointerEvents};
    left: {state.left}px;
    top: {state.top}px;
    position: fixed;
  }

  use Provider.AnimationFrame {
    frames = updateDimensions
  } when {
    shouldCalculate
  }

  get pointerEvents : String {
    if (passThrough) {
      "none"
    } else {
      ""
    }
  }

  /* Renders the element and the panel. */
  fun render : Array(Html) {
    [
      element,
      <Html.Portals.Body>
        <div::panel id={uid}>
          <{ content }>
        </div>
      </Html.Portals.Body>
    ]
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

  fun isFullyVisible (dimensions : Dom.Dimensions) : Bool {
    dimensions.top >= 0 && dimensions.left >= 0 && dimensions.right <= Window.width() && dimensions.bottom <= Window.height()
  }

  fun calculatePosition (position : String, dimensions : Dom.Dimensions, panel : Dom.Dimensions) : Dom.Dimensions {
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

  fun updateDimensions : Void {
    next
      { state |
        left = finalPosition.left,
        top = finalPosition.top
      }
  } where {
    panelDimensions =
      Dom.getElementById(uid)
      |> Maybe.withDefault(Dom.createElement("div"))
      |> Dom.getDimensions()

    dimensions =
      `ReactDOM.findDOMNode(this)`
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
}
