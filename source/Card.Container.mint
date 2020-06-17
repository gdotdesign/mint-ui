component Ui.Card.Container {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property textAlign : String = "left"
  property thumbnail : String = ""
  property subtitle : Html = <></>
  property title : Html = <></>
  property content : Html = <></>

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    font-family: #{actualTheme.fontFamily};
    color: #{actualTheme.content.text};
    text-align: #{textAlign};

    if (!String.isEmpty(thumbnail)) {
      grid-template-columns: 46px 1fr;
    } else {
      grid-template-columns: 1fr;
    }

    grid-template-rows: #{rows};
    grid-gap: 7px 10px;
    display: grid;
    padding: 20px;
    flex: 1;
  }

  style thumbnail {
    grid-row: span 2;
  }

  style title {
    font-weight: bold;
    font-size: 18px;
  }

  style subtitle {
    color: #{actualTheme.contentFaded.text};
    font-size: 14px;
    opacity: 0.66;
  }

  style content {
    if (!String.isEmpty(thumbnail)) {
      grid-column: span 2;
    }

    font-family: #{actualTheme.fontFamily};
    color: #{actualTheme.contentFaded.text};
    line-height: 140%;
    font-size: 14px;
  }

  get rows {
    try {
      size =
        [Html.Extra.isNotEmpty(title), Html.Extra.isNotEmpty(subtitle), Html.Extra.isNotEmpty(content)]
        |> Array.select((item : Bool) { item })
        |> Array.size()

      "repeat(#{size}, min-content)"
    }
  }

  fun render : Html {
    <div::base>
      if (!String.isEmpty(thumbnail)) {
        <div::thumbnail>
          <Ui.Image
            src={thumbnail}
            width={46}
            height={46}/>
        </div>
      }

      if (Html.Extra.isNotEmpty(title)) {
        <div::title>
          <{ title }>
        </div>
      }

      if (Html.Extra.isNotEmpty(subtitle)) {
        <div::subtitle>
          <{ subtitle }>
        </div>
      }

      if (Html.Extra.isNotEmpty(content)) {
        <div::content>
          <{ content }>
        </div>
      }
    </div>
  }
}
