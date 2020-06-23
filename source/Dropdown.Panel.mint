component Ui.Dropdown.Panel {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property children : Array(Html) = []
  property width : String = "auto"
  property size : Number = 16

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    border-radius: #{12.121212 * actualTheme.borderRadiusCoefficient}px;
    box-shadow: 0 2px 10px -2px rgba(0,0,0,0.1);
    border: 1px solid #{actualTheme.border};
    width: #{width};
    padding: 1em;
    font-family: #{actualTheme.fontFamily};
    font-size: #{size};

    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
