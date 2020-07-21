/*
A scrollable container with custom scrollbars and indicators for more items
at the start and end of the container.
*/
component Ui.ScrollPanel {
  connect Ui exposing { resolveTheme }

  /* The theme for the button. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The children to render. */
  property children : Array(Html) = []

  /* The start color of the indicator gradient. */
  property fromColor : String = "rgba(0,0,0,0)"

  /* The end color of the indicator gradient. */
  property toColor : String = "rgba(0,0,0,0.1)"

  /* The orientation, this determines which way the panel should scroll. */
  property orientation : String = "vertical"

  /* Wether or not programatic the scrolling should be animated. */
  property animateScroll : Bool = false

  /* An extra padding from the scroll bars. */
  property extraPadding : Number = 10

  /* The maximum size of the component. */
  property maxSize : Number = 300

  /* The size of the indicator. */
  property size : Number = 20

  /* The current scroll position. */
  state scrollPosition : Number = 0

  /* The current scroll size. */
  state scrollSize : Number = 0

  /* The current client size. */
  state clientSize : Number = 0

  use Provider.ElementSize {
    changes = (dimensions : Dom.Dimensions) { recalculate() },
    element = Maybe.oneOf([horizontal, vertical])
  }

  use Provider.Mutation {
    element = Maybe.oneOf([horizontal, vertical]),
    changes = recalculate
  }

  /* Base style for the component. */
  style base {
    scrollbar-color: #{actualTheme.surface.color} #{actualTheme.contentFaded.color};
    scrollbar-width: thin;
    outline: none;

    if (animateScroll) {
      scroll-behavior: smooth;
    } else {
      scroll-behavior: auto;
    }

    &::before,
    &::after {
      transition: opacity 320ms;
      pointer-events: none;
      position: sticky;
      display: block;
      content: "";
      z-index: 10;
    }

    &::-webkit-scrollbar {
      height: 6px;
      width: 6px;
    }

    &::-webkit-scrollbar-track {
      background: #{actualTheme.contentFaded.color};
    }

    &::-webkit-scrollbar-thumb {
      background: #{actualTheme.surface.color};
    }

    &::-webkit-scrollbar-thumb:hover {
      background: #{actualTheme.surface.color};
    }
  }

  /* Style for the horizontal variant. */
  style horizontal {
    max-width: #{maxSize}px;

    overflow-y: hidden;
    overflow-x: auto;
    display: flex;

    &::before,
    &::after {
      margin-right: -#{size}px;
      min-width: #{size}px;
    }

    &::before {
      background: radial-gradient(ellipse farthest-side at left center, #{toColor}, #{fromColor});
      border-image: linear-gradient(0deg, #{fromColor}, #{toColor}, #{fromColor}) 1;
      border-left: 1px solid;
      left: 0;

      if (scrollPosition == 0) {
        opacity: 0;
      } else {
        opacity: 1;
      }
    }

    &::after {
      background: radial-gradient(ellipse farthest-side at right center, #{toColor}, #{fromColor});
      border-image: linear-gradient(0deg, #{fromColor}, #{toColor}, #{fromColor}) 1;
      border-right: 1px solid;
      right: 0;

      if (scrollPosition == (scrollSize - clientSize)) {
        opacity: 0;
      } else {
        opacity: 1;
      }
    }

    if (scrollSize == clientSize) {
      padding-bottom: 0;
    } else {
      padding-bottom: #{extraPadding}px;
    }
  }

  /* Style for the vertical variant. */
  style vertical {
    max-height: #{maxSize}px;

    overflow-x: hidden;
    overflow-y: auto;

    &::before,
    &::after {
      margin-top: -#{size}px;
      min-height: #{size}px;
    }

    &::before {
      background: radial-gradient(ellipse farthest-side at top center, #{toColor}, #{fromColor});
      border-image: linear-gradient(90deg, #{fromColor}, #{toColor}, #{fromColor}) 1;
      border-top: 1px solid;
      top: 0;

      if (scrollPosition == 0) {
        opacity: 0;
      } else {
        opacity: 1;
      }
    }

    &::after {
      background: radial-gradient(ellipse farthest-side at bottom center, #{toColor}, #{fromColor});
      border-image: linear-gradient(90deg, #{fromColor}, #{toColor}, #{fromColor}) 1;
      border-bottom: 1px solid;
      bottom: 0;

      if (scrollPosition == (scrollSize - clientSize)) {
        opacity: 0;
      } else {
        opacity: 1;
      }
    }

    if (scrollSize == clientSize) {
      padding-right: 0;
    } else {
      padding-right: #{extraPadding}px;
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Sets the state variables from the current state of the element. */
  fun recalculate : Promise(Never, Void) {
    if (orientation == "horizontal") {
      next
        {
          scrollPosition =
            horizontal
            |> Maybe.map(Dom.Extra.getScrollLeft)
            |> Maybe.withDefault(0),
          clientSize =
            horizontal
            |> Maybe.map(Dom.Extra.getClientWidth)
            |> Maybe.withDefault(0),
          scrollSize =
            horizontal
            |> Maybe.map(Dom.Extra.getScrollWidth)
            |> Maybe.withDefault(0)
        }
    } else {
      next
        {
          scrollPosition =
            vertical
            |> Maybe.map(Dom.Extra.getScrollTop)
            |> Maybe.withDefault(0),
          clientSize =
            vertical
            |> Maybe.map(Dom.Extra.getClientHeight)
            |> Maybe.withDefault(0),
          scrollSize =
            vertical
            |> Maybe.map(Dom.Extra.getScrollHeight)
            |> Maybe.withDefault(0)
        }
    }
  }

  /* Renders the component. */
  fun render : Html {
    if (orientation == "horizontal") {
      <div::base::horizontal as horizontal onScroll={recalculate}>
        <{ children }>
      </div>
    } else {
      <div::base::vertical as vertical onScroll={recalculate}>
        <{ children }>
      </div>
    }
  }
}
