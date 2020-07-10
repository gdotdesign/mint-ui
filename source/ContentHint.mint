/* A highlighted hint for some content. */
component Ui.ContentHint {
  connect Ui exposing { resolveTheme }

  /* The theme for the hint. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The children to display. */
  property children : Array(Html) = []

  /* The icon to display. */
  property icon : Html = <></>

  /* The type. */
  property type : String = "primary"

  /* The styles for the base. */
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

  /* The style for the icon. */
  style icon {
    font-size: 1.6em;
    color: #{color};
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Returns the color. */
  get color {
    case (type) {
      "primary" => actualTheme.primary.s500.color
      "warning" => actualTheme.warning.s500.color
      "success" => actualTheme.success.s500.color
      "danger" => actualTheme.danger.s500.color
      => ""
    }
  }

  /* Renders the hint. */
  fun render : Html {
    <div::base>
      <div::icon>
        <Ui.Icon
          autoSize={true}
          icon={icon}/>
      </div>

      <div>
        <{ children }>
      </div>
    </div>
  }
}
