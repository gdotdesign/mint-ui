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
  connect Ui exposing { surfaceBackground, borderRadiusCoefficient }

  property draggable : Bool = true
  property height : Number = 26
  property src : String = ""

  state errored : Bool = false
  state loaded : Bool = false

  style image {
    object-position: center;
    object-fit: cover;

    transition: opacity 120ms;
    border-radius: inherit;
    height: inherit;
    width: inherit;

    if (loaded) {
      opacity: 1;
    } else {
      opacity: 0;
    }
  }

  style base {
    background: #{surfaceBackground};
    height: #{height}px;
    width: 100%;

    &:last-child {
      border-bottom-right-radius: #{24 * borderRadiusCoefficient}px;
      border-bottom-left-radius: #{24 * borderRadiusCoefficient}px;
    }

    &:first-child {
      border-top-right-radius: #{24 * borderRadiusCoefficient}px;
      border-top-left-radius: #{24 * borderRadiusCoefficient}px;
    }
  }

  fun setLoaded : Promise(Never, Void) {
    next { loaded = true }
  }

  fun handleDragStart (event : Html.Event) : Void {
    if (draggable) {
      void
    } else {
      Html.Event.preventDefault(event)
    }
  }

  fun render : Html {
    <div::base>
      <img::image
        onDragStart={handleDragStart}
        onLoad={setLoaded}
        src={src}/>
    </div>
  }
}

component Ui.Card {
  connect Ui exposing { fontFamily, contentBackground, contentText, surfaceBackground, borderRadiusCoefficient }

  property children : Array(Html) = []
  property minWidth : Number = 0
  property href : String = ""

  style base {
    border-radius: #{24 * borderRadiusCoefficient}px;
    min-width: #{minWidth}px;

    flex-direction: column;
    display: flex;

    text-decoration: none;

    background: #{contentBackground};
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
