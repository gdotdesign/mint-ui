component Ui.ContentHint {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property children : Array(Html) = []
  property icon : String = ""
  property type : String = ""

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    grid-template-columns: min-content 1fr;
    align-items: center;
    grid-gap: 1.4em;
    display: grid;

    background: #{actualTheme.contentFaded.color};
    color: #{actualTheme.contentFaded.text};
    border-left: 0.25em solid #{color};

    line-height: 150%;
    padding: 1.25em;
    margin: 1em 0;
  }

  style icon {
    color: #{color};
    font-size: 1.6em;
  }

  get color {
    case (type) {
      "primary" => actualTheme.primary.s500.color
      "warning" => actualTheme.warning.s500.color
      "success" => actualTheme.success.s500.color
      "danger" => actualTheme.danger.s500.color
      => ""
    }
  }

  fun render : Html {
    <div::base>
      <div::icon>
        <Ui.Icon
          autoSize={true}
          name={icon}/>
      </div>

      <div>
        <{ children }>
      </div>
    </div>
  }
}
