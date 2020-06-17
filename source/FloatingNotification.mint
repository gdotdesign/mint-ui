component Ui.FloatingNotification {
  connect Ui exposing { resolveTheme, darkMode, mobile }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property children : Array(Html) = []

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    border-radius: #{24 * actualTheme.borderRadiusCoefficient}px;
    position: fixed;
    padding: 20px;
    color: white;
    bottom: 20px;
    z-index: 200;

    font-family: #{actualTheme.fontFamily};
    text-align: center;
    font-weight: bold;

    if (mobile) {
      transform: none;
      padding: 10px;
      left: 4px;
      right: 4px;
      bottom: 4px;
    } else {
      transform: translateX(-50%);
      bottom: 20px;
      left: 50%;
    }

    @supports (not (backdrop-filter: blur(3px))) {
      if (darkMode) {
        background: rgba(70,70,70,0.92);
      } else {
        background: rgba(30,30,30,0.92);
      }
    }

    @supports (backdrop-filter: blur(3px)) {
      backdrop-filter: blur(3px);

      if (darkMode) {
        background: rgba(80,80,80,0.9);
      } else {
        background: rgba(25,25,25,0.9);
      }
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
