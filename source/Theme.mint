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
  borderDark : String,
  borderLight : String,
  borderRadiusCoefficient : Number,
  fontFamily : String
}

record Ui.Theme.Resolved {
  primary : ColorPalette,
  warning : ColorPalette,
  success : ColorPalette,
  danger : ColorPalette,
  content : ColorPalette.Shade,
  contentFaded : ColorPalette.Shade,
  surface : ColorPalette.Shade,
  border : String,
  borderRadiusCoefficient : Number,
  fontFamily : String
}
