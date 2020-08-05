/* A highlighted hint for some content. */
component Ui.ContentHint {
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

    background: var(--content-faded-color);
    color: var(--content-faded-text);

    case (type) {
      "primary" => border-left: 0.25em solid var(--primary-s500-color);
      "warning" => border-left: 0.25em solid var(--warning-s500-color);
      "success" => border-left: 0.25em solid var(--success-s500-color);
      "danger" => border-left: 0.25em solid var(--danger-s500-color);
      =>
    }

    line-height: 150%;
    padding: 1.25em;
    margin: 1em 0;
  }

  /* The style for the icon. */
  style icon {
    font-size: 1.6em;

    case (type) {
      "primary" => color: var(--primary-s500-color);
      "warning" => color: var(--warning-s500-color);
      "success" => color: var(--success-s500-color);
      "danger" => color: var(--danger-s500-color);
      =>
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
