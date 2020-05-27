component Ui.Card.Container {
  connect Ui exposing { fontFamily, contentText }

  property thumbnail : String = ""
  property subtitle : Html = <></>
  property title : Html = <></>
  property content : Html = <></>

  style base {
    font-family: #{fontFamily};
    color: #{contentText};

    if (`#{thumbnail}`) {
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
    color: #{contentText};
    font-size: 14px;
    opacity: 0.66;
  }

  style content {
    if (`#{thumbnail}`) {
      grid-column: span 2;
    }

    font-family: #{fontFamily};
    color: #{contentText};
    line-height: 140%;
    font-size: 14px;
  }

  get rows {
    try {
      size =
        [!!`#{title}`, !!`#{subtitle}`, !!`#{content}`]
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

      if (`#{title}`) {
        <div::title>
          <{ title }>
        </div>
      }

      if (`#{subtitle}`) {
        <div::subtitle>
          <{ subtitle }>
        </div>
      }

      if (`#{content}`) {
        <div::content>
          <{ content }>
        </div>
      }
    </div>
  }
}

component Ui.Card.Image {
  connect Ui exposing { borderRadiusCoefficient }

  property height : Number = 26
  property src : String = ""

  style base {
    &:last-child > * {
      border-radius: 0 0
                     #{24 * borderRadiusCoefficient}px
                     #{24 * borderRadiusCoefficient}px;
    }

    &:first-child > * {
      border-radius: #{24 * borderRadiusCoefficient}px
                     #{24 * borderRadiusCoefficient}px
                     0 0;
    }

    &:not(:first-child):not(:last-child) > * {
      border-radius: 0;
    }
  }

  fun render : Html {
    <div::base>
      <Ui.Image
        fullWidth={true}
        height={height}
        src={src}/>
    </div>
  }
}

component Ui.Card {
  connect Ui exposing { fontFamily, contentBackgroundFaded, contentText, surfaceBackground, borderRadiusCoefficient, borderColor }

  property children : Array(Html) = []
  property minWidth : Number = 0
  property href : String = ""

  style base {
    border-radius: #{24 * borderRadiusCoefficient}px;
    border: 1px solid #{borderColor};
    min-width: #{minWidth}px;

    flex-direction: column;
    display: flex;

    text-decoration: none;

    background: #{contentBackgroundFaded};
    color: #{contentText};
  }

  fun render : Html {
    if (String.isEmpty(href)) {
      <div::base>
        <{ children }>
      </div>
    } else {
      <a::base href={href}>
        <{ children }>
      </a>
    }
  }
}
