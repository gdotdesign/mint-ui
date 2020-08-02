/* Represents the resolved theme of the components. */
record Ui.Theme.Resolved {
  primary : ColorPalette,
  warning : ColorPalette,
  success : ColorPalette,
  danger : ColorPalette,
  contentFaded : ColorPalette.Shade,
  content : ColorPalette.Shade,
  surface : ColorPalette.Shade,
  borderRadiusCoefficient : Number,
  fontFamily : String,
  border : String
}
