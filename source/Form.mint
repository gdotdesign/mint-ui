component Ui.Form {
  property children : Array(Html) = []

  style base {
    grid-gap: 20px;
    display: grid;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
