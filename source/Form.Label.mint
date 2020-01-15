component Ui.Form.Label {
  connect Ui exposing { fontFamily }

  property fontSize : Number = 16
  property text : String = ""

  style base {
    font-family: #{fontFamily};
    font-size: #{fontSize}px;
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
