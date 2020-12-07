/* A highlighted hint for some content. */
component Ui.ContentHint {
  connect Ui exposing { mobile }

  /* The children to display. */
  property children : Array(Html) = []

  /* The icon to display. */
  property icon : Html = <></>

  /* The type. */
  property type : String = "primary"

  /* The styles for the base. */
  style base {
    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    margin: 1em 0;

    grid-template-columns: auto 1fr;
    display: grid;

    case (type) {
      "primary" =>
        background: var(--primary-s50-color);
        color: var(--primary-s50-text);

      "warning" =>
        background: var(--warning-s50-color);
        color: var(--warning-s50-text);

      "success" =>
        background: var(--success-s50-color);
        color: var(--success-s50-text);

      "danger" =>
        background: var(--danger-s50-color);
        color: var(--danger-s50-text);

      =>
    }
  }

  /* The style for the icon. */
  style icon {
    border-radius: calc(1.5625em * var(--border-radius-coefficient)) 0 0
                   calc(1.5625em * var(--border-radius-coefficient));

    align-items: center;
    display: grid;

    font-size: 2em;
    padding: 0.5em;

    case (type) {
      "primary" =>
        background: var(--primary-s500-color);
        color: var(--primary-s500-text);

      "warning" =>
        background: var(--warning-s500-color);
        color: var(--warning-s500-text);

      "success" =>
        background: var(--success-s500-color);
        color: var(--success-s500-text);

      "danger" =>
        background: var(--danger-s500-color);
        color: var(--danger-s500-text);

      =>
    }
  }

  style content {
    line-height: 150%;
    padding: 1.25em;

    if (mobile) {
      padding: 0.75em;
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

      <div::content>
        <{ children }>
      </div>
    </div>
  }
}
