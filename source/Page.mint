/* A component which represents a page, with default styles. */
component Ui.Page {
  connect Ui exposing { mobile, resolveTheme }

  /* The theme for the button. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The maximum with of the content. */
  property maxContentWidth : String = "auto"

  /* The children to display. */
  property children : Array(Html) = []

  /* Wether or not to center the content. */
  property center : Bool = false

  /* The styles for the page. */
  style base {
    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};
    position: relative;

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

  /* The style for the top corner. */
  style corner-bottom {
    bottom: 0;
    left: 0;
  }

  /* The style for the top corner. */
  style corner-top {
    transform: rotate(180deg);
    right: 0;
    top: 0;
  }

  /* The style for the corner. */
  style corner {
    position: absolute;

    svg {
      fill: #{actualTheme.border};
      display: block;
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

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the page. */
  fun render : Html {
    <div::base as base>
      <div::corner::corner-bottom>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="150"
          height="150"
          viewBox="0 0 39.687 39.699">

          <path d="M.734 0L0 .734v2.212L2.841.106A39.735 39.735 0 00.734 0zM7.54.702L0 8.242v2.213l9.333-9.332A39.735 39.735 0 007.54.702zm5.866 1.643L0 15.752v2.213L15.028 2.937a39.735 39.735 0 00-1.621-.592zm5.227 2.282L0 23.26v2.213l20.04-20.04a39.735 39.735 0 00-1.406-.807zM23.25 7.52L0 30.771v2.212L24.506 8.477a39.735 39.735 0 00-1.257-.956zm4.096 3.414L0 38.28v1.419h.793L28.49 12.002a39.735 39.735 0 00-1.145-1.067zm3.624 3.885L6.09 39.699h2.213l23.605-23.606a39.735 39.735 0 00-.94-1.273zm3.062 4.447L13.6 39.699h2.212l19.026-19.026a39.735 39.735 0 00-.807-1.406zm2.531 4.978L21.108 39.698h2.213l13.885-13.885a39.735 39.735 0 00-.644-1.57zm1.901 5.608l-9.845 9.846h2.212l8.039-8.04a39.735 39.735 0 00-.406-1.806zm1.097 6.412l-3.433 3.434h2.212l1.348-1.349a39.735 39.735 0 00-.127-2.085z"/>

        </svg>
      </div>

      <div::corner::corner-top>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="150"
          height="150"
          viewBox="0 0 39.687 39.699">

          <path d="M.734 0L0 .734v2.212L2.841.106A39.735 39.735 0 00.734 0zM7.54.702L0 8.242v2.213l9.333-9.332A39.735 39.735 0 007.54.702zm5.866 1.643L0 15.752v2.213L15.028 2.937a39.735 39.735 0 00-1.621-.592zm5.227 2.282L0 23.26v2.213l20.04-20.04a39.735 39.735 0 00-1.406-.807zM23.25 7.52L0 30.771v2.212L24.506 8.477a39.735 39.735 0 00-1.257-.956zm4.096 3.414L0 38.28v1.419h.793L28.49 12.002a39.735 39.735 0 00-1.145-1.067zm3.624 3.885L6.09 39.699h2.213l23.605-23.606a39.735 39.735 0 00-.94-1.273zm3.062 4.447L13.6 39.699h2.212l19.026-19.026a39.735 39.735 0 00-.807-1.406zm2.531 4.978L21.108 39.698h2.213l13.885-13.885a39.735 39.735 0 00-.644-1.57zm1.901 5.608l-9.845 9.846h2.212l8.039-8.04a39.735 39.735 0 00-.406-1.806zm1.097 6.412l-3.433 3.434h2.212l1.348-1.349a39.735 39.735 0 00-.127-2.085z"/>

        </svg>
      </div>

      <div::content>
        <{ children }>
      </div>
    </div>
  }
}
