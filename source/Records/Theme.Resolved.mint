/* Represents the resolved theme of the components. */
record Ui.Theme.Resolved {
  contentFaded : ColorPalette.Shade,
  content : ColorPalette.Shade,
  surface : ColorPalette,
  primary : ColorPalette,
  warning : ColorPalette,
  success : ColorPalette,
  danger : ColorPalette,
  borderRadiusCoefficient : Number,
  fontFamily : String,
  border : String
}
