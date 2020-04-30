component Example {
  connect Ui exposing { surfaceBackground, surfaceText, contentBackground }

  property horizontalSpacing : Number = 0
  property data : Tuple(Html, String)
  property controls : Function(Html) = () { <></> }

  state codeShown : Bool = false

  style content {
    background: linear-gradient(45deg,#F6F6F6 25%, transparent 25%, transparent 75%, #F6F6F6 75%, #F6F6F6),
                linear-gradient(45deg,#F6F6F6 25%,transparent 25%,transparent 75%,#F6F6F6 75%,#F6F6F6);

    background-position: 0 0,10px 10px;
    background-size: 20px 20px;
    justify-content: center;

    background-color: #FEFEFE;
    border-radius: 3px;
    justify-content: center;
    align-items: center;
    display: flex;
    overflow: hidden;
    padding: 30px;

    if (horizontalSpacing > 0) {
      grid-gap: #{horizontalSpacing}px;
      grid-auto-flow: column;
      display: grid;
    }
  }

  style pre {
    border-top: 2px solid #F0F0F0;
    background: #F6F6F6;
    color: #333;
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
    border: 2px solid #F0F0F0;
    border-radius: 3px;
    background: #EEE;
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
    border-left: 2px solid #F0F0F0;
    background: #F6F6F6;
    padding: 20px;

    grid-gap: 20px;
    display: grid;
  }

  style wrapper {
    grid-template-columns: 1fr min-content;
    border-radius: 3px 3px 0 0;
    display: grid;
  }

  style code-button {
    justify-content: center;
    align-items: center;
    display: flex;
    height: 40px;
    color: #333;
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
            <{ content }>
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
