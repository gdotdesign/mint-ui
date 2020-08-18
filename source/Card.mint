/* A card component which has items with pre defined structure. */
component Ui.Card {
  connect Ui exposing { darkMode }

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
    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    background: var(--content-faded-color);
    box-shadow: #{boxShadow};

    flex-direction: column;
    display: flex;

    text-decoration: none;
    font-size: #{size}px;

    min-width: #{minWidth}px;
    outline: none;

    > * + * {
      border-top: 0.0625em solid var(--border);
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
      if (String.isNotBlank(href)) {
        box-shadow: 0 0 0.0625em 0.0625em var(--primary-s400-color),
                    0 0 0 0.25em var(--primary-shadow);

        cursor: pointer;
      } else {
        box-shadow: #{boxShadow};
      }
    }
  }

  get boxShadow : String {
    if (darkMode) {
      "0 0 0.0625em 0.0625em var(--border),
       0 0 0 0.25em rgba(0,0,0,0.05)"
    } else {
      "0 0 0.0625em 0.0625em var(--border),
       0 0 0 0.25em rgba(0,0,0,0.015)"
    }
  }

  /* Renders the card. */
  fun render : Html {
    if (String.isBlank(href)) {
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
