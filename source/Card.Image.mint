/* This component is for displaying an image in a card. */
component Ui.Card.Image {
  /* The height of the image. */
  property height : Number = 26

  /* The URL for the image. */
  property src : String = ""

  /* Renders the image. */
  fun render : Html {
    <Ui.Image
      borderRadius="0"
      fullWidth={true}
      height={height}
      src={src}/>
  }
}
