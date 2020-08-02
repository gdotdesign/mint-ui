/* Represents the theme of the components. */
record Ui.Theme {
  primary : ColorPalette,
  warning : ColorPalette,
  success : ColorPalette,
  danger : ColorPalette,
  contentLight : ColorPalette.Shade,
  contentLightFaded : ColorPalette.Shade,
  contentDark : ColorPalette.Shade,
  contentDarkFaded : ColorPalette.Shade,
  surfaceLight : ColorPalette.Shade,
  surfaceDark : ColorPalette.Shade,
  borderLight : String,
  borderDark : String,
  borderRadiusCoefficient : Number,
  fontFamily : String
}
