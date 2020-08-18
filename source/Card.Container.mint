/* This component is for showing structured content in a Card. */
component Ui.Card.Container {
  /* Where to align the text (center, left or right). */
  property textAlign : String = "left"

  /* The thumbnail image. */
  property thumbnail : String = ""

  /* The content for the subtitle field. */
  property subtitle : Html = <></>

  /* The content for the title field. */
  property title : Html = <></>

  /* The content for the content field. */
  property content : Html = <></>

  /* Styles for the base element. */
  style base {
    font-family: var(--font-family);
    color: var(--content-text);
    text-align: #{textAlign};

    if (String.isNotBlank(thumbnail)) {
      grid-template-columns: 3em 1fr;
    } else {
      grid-template-columns: 1fr;
    }

    grid-template-rows: #{rows};
    grid-gap: 0.375em 0.625em;
    display: grid;

    padding: 1.25em;
    flex: 1;
  }

  /* Styles for the thumbnail image. */
  style thumbnail {
    grid-row: span 2;

    > * {
      height: 3em !important;
      width: 3em !important;
    }
  }

  /* Styles for the title. */
  style title {
    font-size: 1.25em;
    font-weight: bold;
    line-height: 1.25;
  }

  /* Styles for the subtitle. */
  style subtitle {
    color: var(--content-faded-text);
    font-size: 0.75em;
    line-height: 1.5;
    opacity: 0.6;
  }

  /* Styles for the content. */
  style content {
    if (String.isNotBlank(thumbnail)) {
      grid-column: span 2;
    }

    font-family: var(--font-family);
    color: var(--content-faded-text);
    font-size: 0.875em;
    line-height: 1.6;
  }

  /*
  Returns the value for the `grid-template-rows` CSS property based on the
  existence of the fields.
  */
  get rows : String {
    try {
      size =
        [
          Html.isNotEmpty(title),
          Html.isNotEmpty(subtitle),
          Html.isNotEmpty(content)
        ]
        |> Array.select((item : Bool) { item })
        |> Array.size()

      "repeat(#{size}, min-content)"
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      if (String.isNotBlank(thumbnail)) {
        <div::thumbnail>
          <Ui.Image src={thumbnail}/>
        </div>
      }

      if (Html.isNotEmpty(title)) {
        <div::title>
          <{ title }>
        </div>
      }

      if (Html.isNotEmpty(subtitle)) {
        <div::subtitle>
          <{ subtitle }>
        </div>
      }

      if (Html.isNotEmpty(content)) {
        <div::content>
          <{ content }>
        </div>
      }
    </div>
  }
}
