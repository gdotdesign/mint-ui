/* Represents the theme of the components. */
record Ui.Theme {
  primary : Color,
  warning : Color,
  success : Color,
  danger : Color,
  contentLight : Color,
  contentLightFaded : Color,
  contentDark : Color,
  contentDarkFaded : Color,
  surfaceLight : Color,
  surfaceDark : Color,
  borderLight : Color,
  borderDark : Color,
  borderRadiusCoefficient : Number,
  fontFamily : String
}

module Ui.Theme {
  fun resolve (theme : Ui.Theme, darkMode : Bool) {
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
}
