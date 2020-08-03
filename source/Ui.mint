/* Represents the store which all components connect to. */
store Ui {
  /* This is the default theme. */
  state defaultTheme : Ui.Theme = {
    contentLightFaded =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("F9F9F9FF"))),
        color = Color.toCSSRGBA(Color::HEX("F9F9F9FF"))
      },
    contentLight =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("FFFFFFFF"))),
        color = Color.toCSSRGBA(Color::HEX("FFFFFFFF"))
      },
    contentDarkFaded =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("2F2F2FFF"))),
        color = Color.toCSSRGBA(Color::HEX("2F2F2FFF"))
      },
    contentDark =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("333333FF"))),
        color = Color.toCSSRGBA(Color::HEX("333333FF"))
      },
    surfaceLight =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("F0F0F0"))),
        color = Color.toCSSRGBA(Color::HEX("F0F0F0"))
      },
    surfaceDark =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("3A3A3AFF"))),
        color = Color.toCSSRGBA(Color::HEX("3A3A3AFF"))
      },
    primary = ColorPalette.fromColor(Color::HEX("0591FCFF")),
    warning = ColorPalette.fromColor(Color::HEX("FFC107FF")),
    success = ColorPalette.fromColor(Color::HEX("26AE3DFF")),
    danger = ColorPalette.fromColor(Color::HEX("F44336FF")),
    borderRadiusCoefficient = 0.16,
    borderLight = "#E9E9E9",
    borderDark = "#262626",
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

  /* Resolves the theme using the default theme as a fallback. */
  fun resolveTheme (theme : Maybe(Ui.Theme)) {
    try {
      resolved =
        Maybe.withDefault(defaultTheme, theme)

      if (darkMode) {
        {
          borderRadiusCoefficient = resolved.borderRadiusCoefficient,
          contentFaded = resolved.contentDarkFaded,
          fontFamily = resolved.fontFamily,
          content = resolved.contentDark,
          surface = resolved.surfaceDark,
          border = resolved.borderDark,
          primary = resolved.primary,
          warning = resolved.warning,
          success = resolved.success,
          danger = resolved.danger
        }
      } else {
        {
          borderRadiusCoefficient = resolved.borderRadiusCoefficient,
          contentFaded = resolved.contentLightFaded,
          fontFamily = resolved.fontFamily,
          content = resolved.contentLight,
          surface = resolved.surfaceLight,
          border = resolved.borderLight,
          primary = resolved.primary,
          warning = resolved.warning,
          success = resolved.success,
          danger = resolved.danger
        }
      }
    }
  }

  /* Sets the border radius coefficient. */
  fun setBorderRadiusCoefficient (value : Number) : Promise(Never, Void) {
    next { defaultTheme = { defaultTheme | borderRadiusCoefficient = value } }
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
