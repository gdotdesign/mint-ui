component Ui.LineGrid {
  property orientation : String = "horizontal"
  property justifyContent : String = "start"
  property alignItems : String = "center"
  property children : Array(Html) = []
  property gap : Number = 10

  style base {
    justify-content: #{justifyContent};
    align-items: #{alignItems};
    display: inline-grid;
    grid-gap: #{gap}px;

    if (orientation == "horizontal") {
      grid-auto-flow: column;
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
