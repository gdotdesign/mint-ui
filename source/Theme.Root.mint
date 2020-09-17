/* Represents a theme. */
component Ui.Theme.Root {
  connect Ui exposing { themeCSS, resolveTheme, darkMode }

  /* The theme. */
  property theme : Ui.Theme = Ui:DEFAULT_THEME

  /* The children to render. */
  property children : Array(Html) = []

  fun render : Html {
    try {
      css =
        themeCSS(resolveTheme(theme))

      styles =
        <style>":root { #{css} }"</style>

      <{
        `_createPortal(#{styles}, document.head)`
        children
      }>
    }
  }
}
