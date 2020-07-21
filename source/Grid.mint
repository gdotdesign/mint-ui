/* A response grid component. */
component Ui.Grid {
  /* The children to render. */
  property children : Array(Html) = []

  /* The minimum width of a column. */
  property width : Number = 200

  /* The gap between columns. */
  property gap : Number = 10

  /* The styles for the grid. */
  style base {
    grid-template-columns: repeat(auto-fill, minmax(#{width}px, 1fr));
    grid-gap: #{gap}px;
    display: grid;
  }

  /* Renders the grid. */
  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
