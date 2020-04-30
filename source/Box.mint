component Ui.Box {
  property children : Array(Html) = []

  property height : Number = 300
  property width : Number = 300

  style base {
    height: #{height}px;
    width: #{width}px;

    display: grid;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
