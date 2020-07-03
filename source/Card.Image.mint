/* This component is for displaying an image in a card. */
component Ui.Card.Image {
  connect Ui exposing { resolveTheme }

  /* The theme for the image. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The height of the image. */
  property height : Number = 26

  /* The URL for the image. */
  property src : String = ""

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the image. */
  fun render : Html {
    <Ui.Image
      borderRadius="0"
      fullWidth={true}
      height={height}
      src={src}/>
  }
}
