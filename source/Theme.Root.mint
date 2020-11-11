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

      scrollbars =
        "
        html {
          scrollbar-color: var(--surface-s600-color) var(--surface-s200-color);
          scrollbar-width: thin;
        }

        html::-webkit-scrollbar {
          cursor: pointer;
          height: 6px;
          width: 6px;
        }

        html::-webkit-scrollbar-track {
          background: var(--surface-s200-color);
        }

        html::-webkit-scrollbar-thumb {
          background: var(--surface-s600-color);
        }
        "

      styles =
        <style>":root { #{css} } #{scrollbars}"</style>

      <{
        `_createPortal(#{styles}, document.head)`
        children
      }>
    }
  }
}
