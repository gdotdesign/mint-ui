component Ui.Page {
  connect Ui exposing { mobile, resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property children : Array(Html) = []

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    if (mobile) {
      padding: 16px;
    } else {
      padding: 32px;
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
