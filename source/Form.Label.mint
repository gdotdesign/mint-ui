component Ui.Form.Label {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property fontSize : Number = 16
  property text : String = ""

  style base {
    font-family: #{actualTheme.fontFamily};
    font-size: #{fontSize}px;

    color: #{actualTheme.content.text};

    white-space: nowrap;
    font-weight: bold;
    line-height: 1;
    flex: 0 0 auto;
    opacity: 0.8;
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
