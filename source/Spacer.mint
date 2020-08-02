/* A component for adding space between elements. */
component Ui.Spacer {
  /* The value for the CSS flex property. */
  property flex : String = "0 0 auto"

  /* The height of the spacer. */
  property height : Number = 0

  /* The width of the spacer. */
  property width : Number = 0

  /* The styles for the spacer. */
  style base {
    height: #{height}px;
    width: #{width}px;
    flex: #{flex};
  }

  /* Renders the spacer. */
  fun render : Html {
    <div::base/>
  }
}
