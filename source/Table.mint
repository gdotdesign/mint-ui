component Ui.Table {
  property headers : Array(String) = []
  property rows : Array(Html) = []

  fun render : Html {
    <table>
      <thead>
        <{ headers }>
      </thead>
    </table>
  }
}
