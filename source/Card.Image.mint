component Ui.Card.Image {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property height : Number = 26
  property src : String = ""

  get actualTheme {
    resolveTheme(theme)
  }

  fun render : Html {
    <Ui.Image
      borderRadius="0"
      fullWidth={true}
      height={height}
      src={src}/>
  }
}
