/* A one axis grid where the items are separated by a gap. */
component Ui.LineGrid {
  /* The orientation of the grid, either `horizontal` or `vertical`. */
  property orientation : String = "horizontal"

  /* Where to justify the content. */
  property justifyContent : String = "start"

  /* Where to align the items. */
  property alignItems : String = "center"

  /* The children to render. */
  property children : Array(Html) = []

  /* The gap between the children. */
  property gap : Number = 10

  /* Styles for the base element. */
  style base {
    justify-content: #{justifyContent};
    align-items: #{alignItems};
    display: inline-grid;
    grid-gap: #{gap}px;

    if (orientation == "horizontal") {
      grid-auto-flow: column;
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
