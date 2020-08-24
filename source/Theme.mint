/* Represents a theme. */
component Ui.Theme {
  connect Ui exposing { resolveTheme, darkMode }

  /* The theme. */
  property theme : Ui.Theme = Ui:DEFAULT_THEME

  /* The children to render. */
  property children : Array(Html) = []

  /* The styles (variables) of the theme. */
  style base (resolved : Ui.Theme.Resolved) {
    /* Primary color variables. */
    --primary-s900-color: #{resolved.primary.s900.color};
    --primary-s900-text: #{resolved.primary.s900.text};

    --primary-s800-color: #{resolved.primary.s800.color};
    --primary-s800-text: #{resolved.primary.s800.text};

    --primary-s700-color: #{resolved.primary.s700.color};
    --primary-s700-text: #{resolved.primary.s700.text};

    --primary-s600-color: #{resolved.primary.s600.color};
    --primary-s600-text: #{resolved.primary.s600.text};

    --primary-s500-color: #{resolved.primary.s500.color};
    --primary-s500-text: #{resolved.primary.s500.text};

    --primary-s400-color: #{resolved.primary.s400.color};
    --primary-s400-text: #{resolved.primary.s400.text};

    --primary-s400-color: #{resolved.primary.s400.color};
    --primary-s400-text: #{resolved.primary.s400.text};

    --primary-s300-color: #{resolved.primary.s300.color};
    --primary-s300-text: #{resolved.primary.s300.text};

    --primary-s200-color: #{resolved.primary.s200.color};
    --primary-s200-text: #{resolved.primary.s200.text};

    --primary-s100-color: #{resolved.primary.s100.color};
    --primary-s100-text: #{resolved.primary.s100.text};

    --primary-s50-color: #{resolved.primary.s50.color};
    --primary-s50-text: #{resolved.primary.s50.text};

    --primary-shadow: hsla(#{resolved.primary.hue}, #{resolved.primary.saturation}%, #{resolved.primary.lightness}%, 0.25);

    /* Warning color variables. */
    --warning-s900-color: #{resolved.warning.s900.color};
    --warning-s900-text: #{resolved.warning.s900.text};

    --warning-s800-color: #{resolved.warning.s800.color};
    --warning-s800-text: #{resolved.warning.s800.text};

    --warning-s700-color: #{resolved.warning.s700.color};
    --warning-s700-text: #{resolved.warning.s700.text};

    --warning-s600-color: #{resolved.warning.s600.color};
    --warning-s600-text: #{resolved.warning.s600.text};

    --warning-s500-color: #{resolved.warning.s500.color};
    --warning-s500-text: #{resolved.warning.s500.text};

    --warning-s400-color: #{resolved.warning.s400.color};
    --warning-s400-text: #{resolved.warning.s400.text};

    --warning-s400-color: #{resolved.warning.s400.color};
    --warning-s400-text: #{resolved.warning.s400.text};

    --warning-s300-color: #{resolved.warning.s300.color};
    --warning-s300-text: #{resolved.warning.s300.text};

    --warning-s200-color: #{resolved.warning.s200.color};
    --warning-s200-text: #{resolved.warning.s200.text};

    --warning-s100-color: #{resolved.warning.s100.color};
    --warning-s100-text: #{resolved.warning.s100.text};

    --warning-s50-color: #{resolved.warning.s50.color};
    --warning-s50-text: #{resolved.warning.s50.text};

    --warning-shadow: hsla(#{resolved.warning.hue}, #{resolved.warning.saturation}%, #{resolved.warning.lightness}%, 0.25);

    /* Danger color variables. */
    --danger-s900-color: #{resolved.danger.s900.color};
    --danger-s900-text: #{resolved.danger.s900.text};

    --danger-s800-color: #{resolved.danger.s800.color};
    --danger-s800-text: #{resolved.danger.s800.text};

    --danger-s700-color: #{resolved.danger.s700.color};
    --danger-s700-text: #{resolved.danger.s700.text};

    --danger-s600-color: #{resolved.danger.s600.color};
    --danger-s600-text: #{resolved.danger.s600.text};

    --danger-s500-color: #{resolved.danger.s500.color};
    --danger-s500-text: #{resolved.danger.s500.text};

    --danger-s400-color: #{resolved.danger.s400.color};
    --danger-s400-text: #{resolved.danger.s400.text};

    --danger-s400-color: #{resolved.danger.s400.color};
    --danger-s400-text: #{resolved.danger.s400.text};

    --danger-s300-color: #{resolved.danger.s300.color};
    --danger-s300-text: #{resolved.danger.s300.text};

    --danger-s200-color: #{resolved.danger.s200.color};
    --danger-s200-text: #{resolved.danger.s200.text};

    --danger-s100-color: #{resolved.danger.s100.color};
    --danger-s100-text: #{resolved.danger.s100.text};

    --danger-s50-color: #{resolved.danger.s50.color};
    --danger-s50-text: #{resolved.danger.s50.text};

    --danger-shadow: hsla(#{resolved.danger.hue}, #{resolved.danger.saturation}%, #{resolved.danger.lightness}%, 0.25);

    /* Success color variables. */
    --success-s900-color: #{resolved.success.s900.color};
    --success-s900-text: #{resolved.success.s900.text};

    --success-s800-color: #{resolved.success.s800.color};
    --success-s800-text: #{resolved.success.s800.text};

    --success-s700-color: #{resolved.success.s700.color};
    --success-s700-text: #{resolved.success.s700.text};

    --success-s600-color: #{resolved.success.s600.color};
    --success-s600-text: #{resolved.success.s600.text};

    --success-s500-color: #{resolved.success.s500.color};
    --success-s500-text: #{resolved.success.s500.text};

    --success-s400-color: #{resolved.success.s400.color};
    --success-s400-text: #{resolved.success.s400.text};

    --success-s400-color: #{resolved.success.s400.color};
    --success-s400-text: #{resolved.success.s400.text};

    --success-s300-color: #{resolved.success.s300.color};
    --success-s300-text: #{resolved.success.s300.text};

    --success-s200-color: #{resolved.success.s200.color};
    --success-s200-text: #{resolved.success.s200.text};

    --success-s100-color: #{resolved.success.s100.color};
    --success-s100-text: #{resolved.success.s100.text};

    --success-s50-color: #{resolved.success.s50.color};
    --success-s50-text: #{resolved.success.s50.text};

    --success-shadow: hsla(#{resolved.success.hue}, #{resolved.success.saturation}%, #{resolved.success.lightness}%, 0.25);

    /* Success color variables. */
    --surface-s900-color: #{resolved.surface.s900.color};
    --surface-s900-text: #{resolved.surface.s900.text};

    --surface-s800-color: #{resolved.surface.s800.color};
    --surface-s800-text: #{resolved.surface.s800.text};

    --surface-s700-color: #{resolved.surface.s700.color};
    --surface-s700-text: #{resolved.surface.s700.text};

    --surface-s600-color: #{resolved.surface.s600.color};
    --surface-s600-text: #{resolved.surface.s600.text};

    --surface-s500-color: #{resolved.surface.s500.color};
    --surface-s500-text: #{resolved.surface.s500.text};

    --surface-s400-color: #{resolved.surface.s400.color};
    --surface-s400-text: #{resolved.surface.s400.text};

    --surface-s400-color: #{resolved.surface.s400.color};
    --surface-s400-text: #{resolved.surface.s400.text};

    --surface-s300-color: #{resolved.surface.s300.color};
    --surface-s300-text: #{resolved.surface.s300.text};

    --surface-s200-color: #{resolved.surface.s200.color};
    --surface-s200-text: #{resolved.surface.s200.text};

    --surface-s100-color: #{resolved.surface.s100.color};
    --surface-s100-text: #{resolved.surface.s100.text};

    --surface-s50-color: #{resolved.surface.s50.color};
    --surface-s50-text: #{resolved.surface.s50.text};

    --surface-shadow: hsla(#{resolved.surface.hue}, #{resolved.surface.saturation}%, #{resolved.surface.lightness}%, 0.25);

    /* Simple colors. */
    --content-faded-color: #{resolved.contentFaded.color};
    --content-faded-text: #{resolved.contentFaded.text};

    --content-color: #{resolved.content.color};
    --content-text: #{resolved.content.text};

    /* Other variables. */
    --border-radius-coefficient: #{resolved.borderRadiusCoefficient};
    --font-family: #{resolved.fontFamily};
    --border: #{resolved.border};

    if (darkMode) {
      --background-lightness: 100%;
    } else {
      --background-lightness: 0%;
    }
  }

  fun render : Html {
    <div::base(resolveTheme(theme))>
      <{ children }>
    </div>
  }
}
