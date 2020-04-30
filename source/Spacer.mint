component Ui.Spacer {
  property flex : String = "0 0 auto"
  property height : Number = 0
  property width : Number = 0

  style base {
    height: #{height}px;
    width: #{width}px;
    flex: #{flex};
  }

  fun render : Html {
    <div::base/>
  }
}
