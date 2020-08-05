/* A card component which has items with pre defined structure. */
component Ui.Card {
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
    box-shadow: 0 0 0.0625em 0.0625em var(--border),
                0 0 0 0.25em var(--content-faded-color);

    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    background: var(--content-faded-color);

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
      if (!String.isEmpty(href)) {
        box-shadow: 0 0 0.0625em 0.0625em var(--primary-s400-color),
                    0 0 0 0.25em var(--primary-shadow);

        cursor: pointer;
      } else {
        box-shadow: 0 0 0.0625em 0.0625em var(--border),
                    0 0 0 0.25em var(--content-faded-color);
      }
    }
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
