/* A floating action button (FAB) represents the primary action of a screen. */
component Ui.FloatingButton {
  /* The click event handler. */
  property onClick : Function(Promise(Never, Void)) = Promise.never

  /* The size of the button. */
  property size : Number = 60

  /* The icon of the button. */
  property icon : Html

  /* The type of the button. */
  property type : String = "primary"

  /* The styles for the button. */
  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    box-shadow: 0 0 #{size * 0.08}px rgba(0,0,0,0.4);
    border-radius: 50%;
    cursor: pointer;
    padding: 0;
    border: 0;
    margin: 0;

    height: #{size}px;
    width: #{size}px;

    justify-content: center;
    align-items: center;
    display: flex;

    case (type) {
      "surface" =>
        background: var(--surface-s500-color);
        color: var(--surface-s500-text);

      "warning" =>
        background: var(--warning-s500-color);
        color: var(--warning-s500-text);

      "success" =>
        background: var(--success-s500-color);
        color: var(--success-s500-text);

      "primary" =>
        background: var(--primary-s500-color);
        color: var(--primary-s500-text);

      "danger" =>
        background: var(--danger-s500-color);
        color: var(--danger-s500-text);

      =>
    }
  }

  /* Renders the button. */
  fun render : Html {
    <button::base onClick={onClick}>
      <Ui.Icon
        size={size / 2}
        icon={icon}/>
    </button>
  }
}
