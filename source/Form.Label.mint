component Ui.Form.Label {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property fontSize : Number = 16
  property text : String = ""

  style base {
    color: #{actualTheme.content.text};
    font-family: #{actualTheme.fontFamily};
    font-size: #{fontSize}px;

    white-space: nowrap;
    font-weight: bold;
    line-height: 1;
    opacity: 0.8;
    flex: 1;
  }

  get actualTheme {
    resolveTheme(theme)
  }

  fun render : Html {
    <div::base>
      <{ text }>
    </div>
  }
}
