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

component Ui.Card {
  connect Ui exposing { resolveTheme }
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  property overflow : String = "hidden"
  property children : Array(Html) = []
  property minWidth : Number = 0
  property href : String = ""

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    border-radius: #{40 * actualTheme.borderRadiusCoefficient}px;

    box-shadow: 0 0 1px 1px #{actualTheme.border},
                0 0 0 4px #{actualTheme.contentFaded.color};

    min-width: #{minWidth}px;

    flex-direction: column;
    display: flex;

    background: #{actualTheme.contentFaded.color};
    text-decoration: none;
    overflow: #{overflow};
    outline: none;

    > * + * {
      border-top: 1px solid #{actualTheme.border};
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:hover,
    &:focus {
      if (!String.isEmpty(href)) {
        box-shadow: 0 0 1px 1px #{actualTheme.primary.s400.color},
                    0 0 0 4px #{actualTheme.primary.shadow};

        cursor: pointer;
      } else {
        box-shadow: 0 0 1px 1px #{actualTheme.border},
                    0 0 0 4px #{actualTheme.contentFaded.color};
      }
    }
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
