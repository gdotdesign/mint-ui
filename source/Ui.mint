/* Represents the store which all components connect to. */
store Ui {
  /* The default theme. */
  const DEFAULT_THEME =
    {
      contentLightFaded = Color::HEX("F6F6F6FF"),
      contentLight = Color::HEX("FCFCFC"),
      contentDarkFaded = Color::HEX("2F2F2FFF"),
      contentDark = Color::HEX("333333FF"),
      surfaceLight = Color::HEX("DDDDDDFF"),
      surfaceDark = Color::HEX("666666FF"),
      primary = Color::HEX("0591FCFF"),
      warning = Color::HEX("FFC107FF"),
      success = Color::HEX("26AE3DFF"),
      danger = Color::HEX("F44336FF"),
      borderRadiusCoefficient = 0.16,
      borderLight = Color::HEX("E6E6E6FF"),
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
        surface = ColorPalette.fromColor(theme.surfaceDark, theme.contentDark, theme.contentLight),
        primary = ColorPalette.fromColor(theme.primary, theme.contentDark, theme.contentLight),
        warning = ColorPalette.fromColor(theme.warning, theme.contentDark, theme.contentLight),
        success = ColorPalette.fromColor(theme.success, theme.contentDark, theme.contentLight),
        danger = ColorPalette.fromColor(theme.danger, theme.contentDark, theme.contentLight),
        contentFaded = ColorPalette.shadeFromColor(theme.contentDarkFaded),
        content = ColorPalette.shadeFromColor(theme.contentDark),
        borderRadiusCoefficient = theme.borderRadiusCoefficient,
        border = Color.toCSSRGBA(theme.borderDark),
        fontFamily = theme.fontFamily
      }
    } else {
      {
        surface = ColorPalette.fromColor(theme.surfaceLight, theme.contentLight, theme.contentDark),
        primary = ColorPalette.fromColor(theme.primary, theme.contentLight, theme.contentDark),
        warning = ColorPalette.fromColor(theme.warning, theme.contentLight, theme.contentDark),
        success = ColorPalette.fromColor(theme.success, theme.contentLight, theme.contentDark),
        danger = ColorPalette.fromColor(theme.danger, theme.contentLight, theme.contentDark),
        contentFaded = ColorPalette.shadeFromColor(theme.contentLightFaded),
        content = ColorPalette.shadeFromColor(theme.contentLight),
        borderRadiusCoefficient = theme.borderRadiusCoefficient,
        border = Color.toCSSRGBA(theme.borderLight),
        fontFamily = theme.fontFamily
      }
    }
  }

  fun themeCSS (resolved : Ui.Theme.Resolved) : String {
    for (key, value of themeMap(resolved)) {
      "#{key}: #{value};"
    }
    |> String.join("\n")
  }

  fun themeMap (resolved : Ui.Theme.Resolved) : Map(String, String) {
    try {
      lightness =
        if (darkMode) {
          100
        } else {
          0
        }

      Map.empty()
      |> Map.set("--primary-s900-color", "#{resolved.primary.s900.color}")
      |> Map.set("--primary-s900-text", "#{resolved.primary.s900.text}")
      |> Map.set("--primary-s800-color", "#{resolved.primary.s800.color}")
      |> Map.set("--primary-s800-text", "#{resolved.primary.s800.text}")
      |> Map.set("--primary-s700-color", "#{resolved.primary.s700.color}")
      |> Map.set("--primary-s700-text", "#{resolved.primary.s700.text}")
      |> Map.set("--primary-s600-color", "#{resolved.primary.s600.color}")
      |> Map.set("--primary-s600-text", "#{resolved.primary.s600.text}")
      |> Map.set("--primary-s500-color", "#{resolved.primary.s500.color}")
      |> Map.set("--primary-s500-text", "#{resolved.primary.s500.text}")
      |> Map.set("--primary-s400-color", "#{resolved.primary.s400.color}")
      |> Map.set("--primary-s400-text", "#{resolved.primary.s400.text}")
      |> Map.set("--primary-s300-color", "#{resolved.primary.s300.color}")
      |> Map.set("--primary-s300-text", "#{resolved.primary.s300.text}")
      |> Map.set("--primary-s200-color", "#{resolved.primary.s200.color}")
      |> Map.set("--primary-s200-text", "#{resolved.primary.s200.text}")
      |> Map.set("--primary-s100-color", "#{resolved.primary.s100.color}")
      |> Map.set("--primary-s100-text", "#{resolved.primary.s100.text}")
      |> Map.set("--primary-s50-color", "#{resolved.primary.s50.color}")
      |> Map.set("--primary-s50-text", "#{resolved.primary.s50.text}")
      |> Map.set("--primary-shadow", "hsla(#{resolved.primary.hue}, #{resolved.primary.saturation}%, #{resolved.primary.lightness}%, 0.25)")
      |> Map.set("--warning-s900-color", "#{resolved.warning.s900.color}")
      |> Map.set("--warning-s900-text", "#{resolved.warning.s900.text}")
      |> Map.set("--warning-s800-color", "#{resolved.warning.s800.color}")
      |> Map.set("--warning-s800-text", "#{resolved.warning.s800.text}")
      |> Map.set("--warning-s700-color", "#{resolved.warning.s700.color}")
      |> Map.set("--warning-s700-text", "#{resolved.warning.s700.text}")
      |> Map.set("--warning-s600-color", "#{resolved.warning.s600.color}")
      |> Map.set("--warning-s600-text", "#{resolved.warning.s600.text}")
      |> Map.set("--warning-s500-color", "#{resolved.warning.s500.color}")
      |> Map.set("--warning-s500-text", "#{resolved.warning.s500.text}")
      |> Map.set("--warning-s400-color", "#{resolved.warning.s400.color}")
      |> Map.set("--warning-s400-text", "#{resolved.warning.s400.text}")
      |> Map.set("--warning-s300-color", "#{resolved.warning.s300.color}")
      |> Map.set("--warning-s300-text", "#{resolved.warning.s300.text}")
      |> Map.set("--warning-s200-color", "#{resolved.warning.s200.color}")
      |> Map.set("--warning-s200-text", "#{resolved.warning.s200.text}")
      |> Map.set("--warning-s100-color", "#{resolved.warning.s100.color}")
      |> Map.set("--warning-s100-text", "#{resolved.warning.s100.text}")
      |> Map.set("--warning-s50-color", "#{resolved.warning.s50.color}")
      |> Map.set("--warning-s50-text", "#{resolved.warning.s50.text}")
      |> Map.set("--warning-shadow", "hsla(#{resolved.warning.hue}, #{resolved.warning.saturation}%, #{resolved.warning.lightness}%, 0.25)")
      |> Map.set("--danger-s900-color", "#{resolved.danger.s900.color}")
      |> Map.set("--danger-s900-text", "#{resolved.danger.s900.text}")
      |> Map.set("--danger-s800-color", "#{resolved.danger.s800.color}")
      |> Map.set("--danger-s800-text", "#{resolved.danger.s800.text}")
      |> Map.set("--danger-s700-color", "#{resolved.danger.s700.color}")
      |> Map.set("--danger-s700-text", "#{resolved.danger.s700.text}")
      |> Map.set("--danger-s600-color", "#{resolved.danger.s600.color}")
      |> Map.set("--danger-s600-text", "#{resolved.danger.s600.text}")
      |> Map.set("--danger-s500-color", "#{resolved.danger.s500.color}")
      |> Map.set("--danger-s500-text", "#{resolved.danger.s500.text}")
      |> Map.set("--danger-s400-color", "#{resolved.danger.s400.color}")
      |> Map.set("--danger-s400-text", "#{resolved.danger.s400.text}")
      |> Map.set("--danger-s300-color", "#{resolved.danger.s300.color}")
      |> Map.set("--danger-s300-text", "#{resolved.danger.s300.text}")
      |> Map.set("--danger-s200-color", "#{resolved.danger.s200.color}")
      |> Map.set("--danger-s200-text", "#{resolved.danger.s200.text}")
      |> Map.set("--danger-s100-color", "#{resolved.danger.s100.color}")
      |> Map.set("--danger-s100-text", "#{resolved.danger.s100.text}")
      |> Map.set("--danger-s50-color", "#{resolved.danger.s50.color}")
      |> Map.set("--danger-s50-text", "#{resolved.danger.s50.text}")
      |> Map.set("--danger-shadow", "hsla(#{resolved.danger.hue}, #{resolved.danger.saturation}%, #{resolved.danger.lightness}%, 0.25)")
      |> Map.set("--success-s900-color", "#{resolved.success.s900.color}")
      |> Map.set("--success-s900-text", "#{resolved.success.s900.text}")
      |> Map.set("--success-s800-color", "#{resolved.success.s800.color}")
      |> Map.set("--success-s800-text", "#{resolved.success.s800.text}")
      |> Map.set("--success-s700-color", "#{resolved.success.s700.color}")
      |> Map.set("--success-s700-text", "#{resolved.success.s700.text}")
      |> Map.set("--success-s600-color", "#{resolved.success.s600.color}")
      |> Map.set("--success-s600-text", "#{resolved.success.s600.text}")
      |> Map.set("--success-s500-color", "#{resolved.success.s500.color}")
      |> Map.set("--success-s500-text", "#{resolved.success.s500.text}")
      |> Map.set("--success-s400-color", "#{resolved.success.s400.color}")
      |> Map.set("--success-s400-text", "#{resolved.success.s400.text}")
      |> Map.set("--success-s300-color", "#{resolved.success.s300.color}")
      |> Map.set("--success-s300-text", "#{resolved.success.s300.text}")
      |> Map.set("--success-s200-color", "#{resolved.success.s200.color}")
      |> Map.set("--success-s200-text", "#{resolved.success.s200.text}")
      |> Map.set("--success-s100-color", "#{resolved.success.s100.color}")
      |> Map.set("--success-s100-text", "#{resolved.success.s100.text}")
      |> Map.set("--success-s50-color", "#{resolved.success.s50.color}")
      |> Map.set("--success-s50-text", "#{resolved.success.s50.text}")
      |> Map.set("--success-shadow", "hsla(#{resolved.success.hue}, #{resolved.success.saturation}%, #{resolved.success.lightness}%, 0.25)")
      |> Map.set("--surface-s900-color", "#{resolved.surface.s900.color}")
      |> Map.set("--surface-s900-text", "#{resolved.surface.s900.text}")
      |> Map.set("--surface-s800-color", "#{resolved.surface.s800.color}")
      |> Map.set("--surface-s800-text", "#{resolved.surface.s800.text}")
      |> Map.set("--surface-s700-color", "#{resolved.surface.s700.color}")
      |> Map.set("--surface-s700-text", "#{resolved.surface.s700.text}")
      |> Map.set("--surface-s600-color", "#{resolved.surface.s600.color}")
      |> Map.set("--surface-s600-text", "#{resolved.surface.s600.text}")
      |> Map.set("--surface-s500-color", "#{resolved.surface.s500.color}")
      |> Map.set("--surface-s500-text", "#{resolved.surface.s500.text}")
      |> Map.set("--surface-s400-color", "#{resolved.surface.s400.color}")
      |> Map.set("--surface-s400-text", "#{resolved.surface.s400.text}")
      |> Map.set("--surface-s300-color", "#{resolved.surface.s300.color}")
      |> Map.set("--surface-s300-text", "#{resolved.surface.s300.text}")
      |> Map.set("--surface-s200-color", "#{resolved.surface.s200.color}")
      |> Map.set("--surface-s200-text", "#{resolved.surface.s200.text}")
      |> Map.set("--surface-s100-color", "#{resolved.surface.s100.color}")
      |> Map.set("--surface-s100-text", "#{resolved.surface.s100.text}")
      |> Map.set("--surface-s50-color", "#{resolved.surface.s50.color}")
      |> Map.set("--surface-s50-text", "#{resolved.surface.s50.text}")
      |> Map.set("--surface-shadow", "hsla(#{resolved.surface.hue}, #{resolved.surface.saturation}%, #{resolved.surface.lightness}%, 0.25)")
      |> Map.set("--content-faded-color", "#{resolved.contentFaded.color}")
      |> Map.set("--content-faded-text", "#{resolved.contentFaded.text}")
      |> Map.set("--content-color", "#{resolved.content.color}")
      |> Map.set("--content-text", "#{resolved.content.text}")
      |> Map.set("--border-radius-coefficient", "#{resolved.borderRadiusCoefficient}")
      |> Map.set("--font-family", "#{resolved.fontFamily}")
      |> Map.set("--border", "#{resolved.border}")
      |> Map.set("--background-lightness", "#{lightness}%")
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
