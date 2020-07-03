/* A card component which has items with pre defined structure. */
component Ui.Card {
  connect Ui exposing { resolveTheme }

  /* The theme for the card. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The child elements. */
  property children : Array(Html) = []

  /* The minimum width of the card. */
  property minWidth : Number = 0

  /* The URL to link the card to. */
  property href : String = ""

  /* The size of the component. */
  property size : Number = 16

  /* Styles for the card. */
  style base {
    border-radius: #{1.5625 * actualTheme.borderRadiusCoefficient}em;

    box-shadow: 0 0 0.0625em 0.0625em #{actualTheme.border},
                0 0 0 0.25em #{actualTheme.contentFaded.color};

    min-width: #{minWidth}px;

    flex-direction: column;
    display: flex;

    background: #{actualTheme.contentFaded.color};
    outline: none;

    text-decoration: none;
    font-size: #{size}px;

    > * + * {
      border-top: 0.0625em solid #{actualTheme.border};
    }

    > *:first-child {
      border-top-right-radius: inherit;
      border-top-left-radius: inherit;
    }

    > *:last-child {
      border-bottom-right-radius: inherit;
      border-bottom-left-radius: inherit;
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:hover,
    &:focus {
      if (!String.isEmpty(href)) {
        box-shadow: 0 0 0.0625em 0.0625em #{actualTheme.primary.s400.color},
                    0 0 0 0.25em #{actualTheme.primary.shadow};

        cursor: pointer;
      } else {
        box-shadow: 0 0 0.0625em 0.0625em #{actualTheme.border},
                    0 0 0 0.25em #{actualTheme.contentFaded.color};
      }
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the card. */
  fun render : Html {
    if (String.isEmpty(href)) {
      <div::base>
        <{ children }>
      </div>
    } else {
      <a::base href={href}>
        <{ children }>
      </a>
    }
  }
}
