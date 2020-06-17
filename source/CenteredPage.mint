component Ui.CenteredPage {
  connect Ui exposing { resolveTheme, contentBackground, contentText, mobile }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property children : Array(Html) = []

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    justify-content: center;
    flex-direction: column;
    align-items: center;
    display: flex;

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
