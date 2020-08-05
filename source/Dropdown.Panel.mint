/* This component is usually used inside of a dropdown. */
component Ui.Dropdown.Panel {
  connect Ui exposing { mobile }

  /* The children to display. */
  property children : Array(Html) = []

  /* The width of the panel. */
  property width : String = "auto"

  /* The size of the panel. */
  property size : Number = 16

  /* Styles for the panel. */
  style base {
    box-shadow: 0 0.125em 0.625em -0.125em rgba(0,0,0,0.1);

    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    border: 0.0625em solid var(--border);

    background: var(--content-color);
    width: #{width};
    padding: 0.5em;

    font-family: var(--font-family);
    color: var(--content-text);
    font-size: #{size}px;

    if (mobile) {
      padding: 0.75em;
    }
  }

  /* Renders the panel. */
  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
