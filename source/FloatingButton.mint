/* A floating action button (FAB) represents the primary action of a screen. */
component Ui.FloatingButton {
  connect Ui exposing { resolveTheme }

  /* The click event handler. */
  property onClick : Function(Promise(Never, Void)) = Promise.never

  /* The theme for the button. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The size of the button. */
  property size : Number = 60

  /* The icon of the button. */
  property icon : Html

  /* The styles for the button. */
  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    box-shadow: 0 0 #{size * 0.08}px rgba(0,0,0,0.25);

    background: #{actualTheme.primary.s500.color};
    border-radius: 50%;
    padding: 0;
    border: 0;
    margin: 0;

    height: #{size}px;
    width: #{size}px;

    cursor: pointer;
    color: white;

    justify-content: center;
    align-items: center;
    display: flex;
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
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
