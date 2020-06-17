component Example {
  connect Ui exposing { resolveTheme }

  property horizontalSpacing : Number = 0
  property verticalSpacing : Number = 0

  property fill : Bool = false

  property data : Tuple(Html, String)
  property controls : Function(Html) = () { <></> }
  property breakpoint : Number = 1000

  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  state codeShown : Bool = false
  state mobile : Bool = false

  use Provider.ElementSize {
    changes = (dimensions : Dom.Dimensions) { next { mobile = dimensions.width < breakpoint } },
    element = base
  }

  get actualTheme {
    resolveTheme(theme)
  }

  style content {
    background: linear-gradient(45deg, #{actualTheme.contentFaded.color} 25%, transparent 25%, transparent 75%,  #{actualTheme.contentFaded.color} 75%,  #{actualTheme.contentFaded.color}),
                linear-gradient(45deg, #{actualTheme.contentFaded.color} 25%, transparent 25%,transparent 75%, #{actualTheme.contentFaded.color} 75%, #{actualTheme.contentFaded.color});

    background-color: #{actualTheme.content.color};
    background-position: 0 0,10px 10px;
    background-size: 20px 20px;
    border-radius: 4px 4px 0 0;

    if (fill) {
      display: grid;
    } else {
      justify-content: center;
      align-items: center;
      display: flex;
    }

    overflow: hidden;
    padding: 30px;
  }

  style content-wrapper {
    if (horizontalSpacing > 0 && !mobile) {
      grid-gap: #{horizontalSpacing}px;
      grid-auto-flow: column;
      align-items: center;
    }

    if (mobile) {
      grid-gap: #{horizontalSpacing}px;
    }

    if (verticalSpacing > 0) {
      grid-gap: #{verticalSpacing}px;
    }

    display: grid;
  }

  style pre {
    border-top: 1px solid #{actualTheme.border};
    background: #{actualTheme.contentFaded.color};
    color: #{actualTheme.contentFaded.text};
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
    box-shadow: 0 0 0 3px #{actualTheme.contentFaded.color};
    border: 1px solid #{actualTheme.border};
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
    border-left: 1px solid #{actualTheme.border};
    background: #{actualTheme.contentFaded.color};
    color: #{actualTheme.contentFaded.text};

    padding: 20px;
    grid-gap: 20px;
    align-content: start;
    align-items: start;
    display: grid;

    if (mobile) {
      min-width: 0;
    } else {
      min-width: 300px;
    }
  }

  style wrapper {
    border-radius: 3px 3px 0 0;
    display: grid;

    if (mobile) {
      grid-template-columns: 1fr;
    } else {
      grid-template-columns: 1fr min-content;
    }
  }

  fun render : Html {
    try {
      controlsHtml =
        controls()

      {content, code} =
        data

      <div::base as base>
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
