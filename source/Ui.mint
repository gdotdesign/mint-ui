/* Represents the store which all components connect to. */
store Ui {
  /* The default theme. */
  const DEFAULT_THEME = {
    contentLightFaded = Color::HEX("F9F9F9FF"),
    contentLight = Color::HEX("FFFFFFFF"),
    contentDarkFaded = Color::HEX("2F2F2FFF"),
    contentDark = Color::HEX("333333FF"),
    surfaceLight = Color::HEX("F0F0F0"),
    surfaceDark = Color::HEX("3A3A3AFF"),
    primary = Color::HEX("0591FCFF"),
    warning = Color::HEX("FFC107FF"),
    success = Color::HEX("26AE3DFF"),
    danger = Color::HEX("F44336FF"),
    borderRadiusCoefficient = 0.16,
    borderLight = Color::HEX("E9E9E9FF"),
    borderDark = Color::HEX("262626FF"),
    fontFamily = "Arial"
  }

  /* Wether or not we are in a mobile view. */
  state mobile : Bool = Window.matchesMediaQuery("(max-width: 1000px)")

  /* Wether or not to show dark mode. */
  state darkMode : Bool = true

  /* A media query listener for to set mobile property. */
  state mediaQueryListener = Window.addMediaQueryListener(
    "(max-width: 1000px)",
    (active : Bool) { next { mobile = active } })

  /* Resolves a theme. */
  fun resolveTheme (theme : Ui.Theme) {
    if (darkMode) {
      {
        primary = ColorPalette.fromColor(theme.primary, theme.contentDark, theme.contentLight),
        warning = ColorPalette.fromColor(theme.warning, theme.contentDark, theme.contentLight),
        success = ColorPalette.fromColor(theme.success, theme.contentDark, theme.contentLight),
        danger = ColorPalette.fromColor(theme.danger, theme.contentDark, theme.contentLight),
        contentFaded = ColorPalette.shadeFromColor(theme.contentDarkFaded),
        content = ColorPalette.shadeFromColor(theme.contentDark),
        surface = ColorPalette.shadeFromColor(theme.surfaceDark),
        borderRadiusCoefficient = theme.borderRadiusCoefficient,
        border = Color.toCSSRGBA(theme.borderDark),
        fontFamily = theme.fontFamily
      }
    } else {
      {
        primary = ColorPalette.fromColor(theme.primary, theme.contentLight, theme.contentDark),
        warning = ColorPalette.fromColor(theme.warning, theme.contentLight, theme.contentDark),
        success = ColorPalette.fromColor(theme.success, theme.contentLight, theme.contentDark),
        danger = ColorPalette.fromColor(theme.danger, theme.contentLight, theme.contentDark),
        contentFaded = ColorPalette.shadeFromColor(theme.contentLightFaded),
        content = ColorPalette.shadeFromColor(theme.contentLight),
        surface = ColorPalette.shadeFromColor(theme.surfaceLight),
        borderRadiusCoefficient = theme.borderRadiusCoefficient,
        border = Color.toCSSRGBA(theme.borderLight),
        fontFamily = theme.fontFamily
      }
    }
  }

  /* Sets the dark mode state. */
  fun setDarkMode (value : Bool) : Promise(Never, Void) {
    next { darkMode = value }
  }

  /* A function to not do anything based on a disabled argument. */
  fun disabledHandler (
    disabled : Bool,
    handler : Function(a, Promise(Never, Void))
  ) : Function(a, Promise(Never, Void)) {
    if (disabled) {
      Promise.never1()
    } else {
      handler
    }
  }
}
