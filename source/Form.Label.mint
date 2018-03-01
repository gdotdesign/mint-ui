component Ui.Form.Label {
  property theme : Ui.Theme = Ui.defaultTheme()
  property fontSize : Number = 16
  property text : String = ""

  style base {
    font-size: {Number.toString(fontSize)}px;
    font-family: {theme.fontFamily};
    font-weight: bold;
    opacity: 0.8;
    color: #333;
    flex: 1;
  }

  fun render : Html {
    <div::base>
      <{ text }>
    </div>
  }
}
