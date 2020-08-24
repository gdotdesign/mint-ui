/* Represents a theme. */
component Ui.Theme {
  connect Ui exposing { themeMap, resolveTheme, darkMode }

  /* The theme. */
  property theme : Ui.Theme = Ui:DEFAULT_THEME

  /* The children to render. */
  property children : Array(Html) = []

  fun render : Html {
    <div style={themeMap(resolveTheme(theme))}>
      <{ children }>
    </div>
  }
}
