component Ui.Grid {
  property children : Array(Html) = []
  property width : Number = 200
  property gap : Number = 10

  style base {
    grid-template-columns: repeat(auto-fill, minmax(#{width}px, 1fr));
    grid-gap: #{gap}px;
    display: grid;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
