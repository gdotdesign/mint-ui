/* A component which represents a page, with default styles. */
component Ui.Page {
  connect Ui exposing { mobile }

  /* The value for the `background` CSS property. */
  property background : String = ""

  /* The maximum with of the content. */
  property maxContentWidth : String = "auto"

  /* The children to display. */
  property children : Array(Html) = []

  /* Wether or not to center the content. */
  property center : Bool = false

  /* The styles for the page. */
  style base {
    color: var(--content-text);
    position: relative;

    if (String.isNotBlank(background)) {
      background: #{background};
    } else {
      background: var(--content-color);
    }

    if (center) {
      grid-template-columns: minmax(0, #{maxContentWidth});
      justify-content: center;
      display: grid;
    } else {
      display: block;
    }

    if (mobile) {
      padding: 32px 16px;
    } else {
      padding: 32px;
    }
  }

  /* The style for the content. */
  style content {
    position: relative;
    z-index: 1;

    if (center) {
      margin: auto 0;
    }
  }

  /* Renders the page. */
  fun render : Html {
    <div::base as base>
      <div::content>
        <{ children }>
      </div>
    </div>
  }
}
