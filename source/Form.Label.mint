component Ui.Form.Label {
  connect Ui exposing { fontFamily, contentText }

  property fontSize : Number = 16
  property text : String = ""

  style base {
    font-family: #{fontFamily};
    font-size: #{fontSize}px;
    white-space: nowrap;
    color: #{contentText};
    font-weight: bold;
    opacity: 0.8;
    flex: 1;
  }

  fun render : Html {
    <div::base>
      <{ text }>
    </div>
  }
}
