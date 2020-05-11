component Example {
  connect Ui exposing { surfaceBackground, surfaceText, contentBackground, contentBackgroundFaded, borderColor, contentText }

  property horizontalSpacing : Number = 0
  property verticalSpacing : Number = 0

  property maxWidth : Number = 0

  property data : Tuple(Html, String)
  property controls : Function(Html) = () { <></> }

  state codeShown : Bool = false

  style content {
    background: linear-gradient(45deg,#{contentBackgroundFaded} 25%, transparent 25%, transparent 75%, #{contentBackgroundFaded} 75%, #{contentBackgroundFaded}),
                linear-gradient(45deg,#{contentBackgroundFaded} 25%,transparent 25%,transparent 75%,#{contentBackgroundFaded} 75%,#{contentBackgroundFaded});

    background-position: 0 0,10px 10px;
    background-size: 20px 20px;
    justify-content: center;

    background-color: #{contentBackground};
    justify-content: center;
    align-items: center;
    display: flex;
    overflow: hidden;
    padding: 30px;
  }

  style content-wrapper {
    if (horizontalSpacing > 0) {
      grid-gap: #{horizontalSpacing}px;
      grid-auto-flow: column;
      align-items: center;
    }

    if (verticalSpacing > 0) {
      grid-gap: #{verticalSpacing}px;
    }

    display: grid;
  }

  style pre {
    border-top: 1px solid #{borderColor};
    background: #{contentBackgroundFaded};
    color: #{contentText};
    padding: 20px;
    margin: 0;

    overflow: auto;

    code {
      all: unset;
      font-size: 16px;
      line-height: 150%;
      font-family: monospace;
    }
  }

  style base {
    border: 1px solid #{borderColor};
    border-radius: 3px;
    position: relative;
  }

  style buttons {
    position: absolute;
    top: 0;
    right: 0;
    padding: 10px;
    display: flex;
    align-items: center;
  }

  style controls {
    border-left: 1px solid #{borderColor};
    background: #{contentBackgroundFaded};
    padding: 20px;
    min-width: 300px;
    grid-gap: 20px;
    align-content: start;
    align-items: start;
    display: grid;
  }

  style wrapper {
    grid-template-columns: 1fr min-content;
    border-radius: 3px 3px 0 0;
    display: grid;
  }

  fun render : Html {
    try {
      controlsHtml =
        controls()

      {content, code} =
        data

      <div::base>
        <div::wrapper>
          <div::content>
            <div::content-wrapper>
              <{ content }>
            </div>
          </div>

          if (`#{controlsHtml}`) {
            <div::controls>
              <{ controlsHtml }>
            </div>
          }
        </div>

        <pre::pre>
          <code>
            <{ code }>
          </code>
        </pre>
      </div>
    }
  }
}
