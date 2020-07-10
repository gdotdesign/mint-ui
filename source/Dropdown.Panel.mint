/* This component is usually used inside of a dropdown. */
component Ui.Dropdown.Panel {
  connect Ui exposing { resolveTheme }

  /* The theme for the hint. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The children to display. */
  property children : Array(Html) = []

  /* The width of the panel. */
  property width : String = "auto"

  /* The size of the panel. */
  property size : Number = 16

  /* Styles for the panel. */
  style base {
    box-shadow: 0 0.125em 0.625em -0.125em rgba(0,0,0,0.1);

    border-radius: #{1.5625 * actualTheme.borderRadiusCoefficient}em;
    border: 0.0625em solid #{actualTheme.border};

    background: #{actualTheme.content.color};
    width: #{width};
    padding: 1em;

    font-family: #{actualTheme.fontFamily};
    font-size: #{size};
    color: #{actualTheme.content.text};
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the panel. */
  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
