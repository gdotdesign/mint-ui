component Ui.ScrollPanel {
  connect Ui exposing { surfaceBackground, contentBackgroundFaded }

  state scrollPosition : Number = 0
  state scrollSize : Number = 0
  state clientSize : Number = 0

  property children : Array(Html) = []

  property fromColor : String = "rgba(0,0,0,0)"
  property toColor : String = "rgba(0,0,0,0.3)"

  property orientation : String = "vertical"
  property animateScroll : Bool = false
  property extraPadding : Number = 10
  property maxSize : Number = 300
  property size : Number = 20

  fun componentWillUnmount : Promise(Never, Void) {
    `
    (() => {
      this.resizeObserver && this.resizeObserver.disconnect()
      this.observer && this.observer.disconnect()
    })
    `
  }

  fun componentDidMount : Promise(Never, Void) {
    try {
      element =
        Maybe.oneOf(
          [
            horizontal,
            vertical
          ])
        |> Maybe.toResult("")

      `
      (() => {
        this.observer = new MutationObserver(() => {
          #{recalculate()}
        });
        this.resizeObserver = new ResizeObserver(entries => {
          #{recalculate()}
        });

        this.resizeObserver.observe(#{element});
        this.observer.observe(#{element},{subtree: true, childList: true});
      })()
      `
    } catch {
      ``
    }
  }

  style base {
    scrollbar-color: #{surfaceBackground} #{contentBackgroundFaded};
    scrollbar-width: thin;

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
      background: #{contentBackgroundFaded};
    }

    &::-webkit-scrollbar-thumb {
      background: #{surfaceBackground};
    }

    &::-webkit-scrollbar-thumb:hover {
      background: #{surfaceBackground};
    }
  }

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

  fun recalculate : Promise(Never, Void) {
    if (orientation == "horizontal") {
      next
        {
          scrollPosition = `this._horizontal._0 && this._horizontal._0.scrollLeft`,
          clientSize = `this._horizontal._0 && this._horizontal._0.clientWidth`,
          scrollSize = `this._horizontal._0 && this._horizontal._0.scrollWidth`
        }
    } else {
      next
        {
          scrollPosition = `this._vertical._0 && this._vertical._0.scrollTop`,
          clientSize = `this._vertical._0 && this._vertical._0.clientHeight`,
          scrollSize = `this._vertical._0 && this._vertical._0.scrollHeight`
        }
    }
  }

  fun render : Html {
    if (orientation == "horizontal") {
      <div::base::horizontal as horizontal onScroll={recalculate}>
        <div>
          <{ children }>
        </div>
      </div>
    } else {
      <div::base::vertical as vertical onScroll={recalculate}>
        <div>
          <{ children }>
        </div>
      </div>
    }
  }
}
