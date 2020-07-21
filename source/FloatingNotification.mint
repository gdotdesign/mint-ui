/* A floating notification at the bottom center of the screen. */
component Ui.FloatingNotification {
  connect Ui exposing { resolveTheme, darkMode, mobile }

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The children to render. */
  property children : Array(Html) = []

  /* The size of the component. */
  property size : Number = 16

  style base {
    border-radius: #{24 * actualTheme.borderRadiusCoefficient}px;
    position: fixed;
    z-index: 200;
    padding: 1em;
    color: white;
    bottom: 1em;

    font-family: #{actualTheme.fontFamily};
    font-size: #{size}px;
    text-align: center;
    font-weight: bold;

    if (mobile) {
      transform: none;
      padding: 0.75em;
      bottom: 0.25em;
      right: 0.25em;
      left: 0.25em;
    } else {
      transform: translateX(-50%);
      bottom: 1em;
      left: 50%;
    }

    if (darkMode) {
      background: rgba(70,70,70,0.92);
    } else {
      background: rgba(30,30,30,0.92);
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the notification. */
  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
