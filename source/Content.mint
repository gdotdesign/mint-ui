component Ui.Content {
  connect Ui exposing {
    resolveTheme,
    mobile
  }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property children : Array(Html) = []
  property textAlign : String = ""
  property padding : Bool = false

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    font-family: #{actualTheme.fontFamily};
    text-align: #{textAlign};
    line-height: 170%;

    if (padding && mobile) {
      padding: 16px;
    } else if (padding) {
      padding: 32px;
    } else {
      padding: 0;
    }

    > *:first-child {
      margin-top: 0;
    }

    > *:last-child {
      margin-bottom: 0;
    }

    h2 {
      margin-top: 2em;
    }

    li + li {
      margin-top: 0.5em;
    }

    a:not([name]):not([class]) {
      color: #{actualTheme.primary.s500.color};
    }

    code {
      background: #{actualTheme.contentFaded.color};
      color: #{actualTheme.contentFaded.text};

      border: 1px solid #{actualTheme.border};
      border-radius: 2px;

      display: inline-block;
      padding: 2px 6px 0px;
      font-size: 14px;
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
