/* This component is usually used inside of a dropdown. */
component Ui.Dropdown.Panel {
  connect Ui exposing { mobile }

  /* The children to display. */
  property children : Array(Html) = []

  /* The width of the panel. */
  property width : String = "auto"

  /* The size of the panel. */
  property size : Number = 16

  /* The title of the panel. */
  property title : Html = <></>

  /* Styles for the panel. */
  style base {
    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    box-shadow: 0 0.125em 0.625em -0.125em rgba(0,0,0,0.1);
    border: 0.0625em solid var(--border);

    background: var(--content-color);
    width: #{width};

    font-family: var(--font-family);
    color: var(--content-text);
    font-size: #{size}px;
  }

  /* Styles for the title. */
  style title {
    border-radius: calc(1.5625em * var(--border-radius-coefficient))
                   calc(1.5625em * var(--border-radius-coefficient))
                   0 0;

    /* The padding here is using the size because the font-size is smaller. */
    padding: #{0.5 * size}px #{0.75 * size}px;
    border-bottom: 1px solid var(--border);
    background: var(--content-faded-color);
    color: var(--content-faded-text);
    font-size: 0.875em;
    font-weight: bold;
  }

  /* Styles for the content. */
  style content {
    padding: 0.75em;
  }

  /* Renders the panel. */
  fun render : Html {
    <div::base as base>
      if (Html.isNotEmpty(title)) {
        <div::title>
          <{ title }>
        </div>
      }

      <div::content>
        <{ children }>
      </div>
    </div>
  }
}
