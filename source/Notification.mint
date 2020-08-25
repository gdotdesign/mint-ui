/* A component for displaying a notification. */
component Ui.Notification {
  /* The duration of the notification. */
  property duration : Number = 0

  /* The content to display in the notification. */
  property content : Html = <{  }>

  /* A state for tracking the whether or not the notification is shown. */
  state shown : Bool = false

  /* Styles for the base element. */
  style base {
    height: #{height}px;
    overflow: visible;

    if (shown) {
      transition: transform 320ms;
      transform: translateX(0);
      margin-bottom: 10px;
    } else {
      transform: translateX(100%) translateX(20px);

      transition: transform 320ms,
                  height 320ms 200ms,
                  margin-bottom 320ms 200ms;

      margin-bottom: 0;
    }
  }

  /* Styles for the content. */
  style content {
    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    box-shadow: 0 0 1em rgba(0, 0, 0, 0.2);
    background: rgba(25, 25, 25, 0.975);
    font-family: var(--font-family);
    padding: 1em 1.5em;
    font-weight: 600;
    cursor: pointer;
    display: block;
    color: white;

    @media (max-width: 900px) {
      font-size: 0.875em;
    }
  }

  /* Returns the height of the component in pixels. */
  get height : Number {
    if (shown) {
      base
      |> Maybe.map(Dom.getDimensions)
      |> Maybe.map(.height)
      |> Maybe.withDefault(0)
    } else {
      0
    }
  }

  /* Runs when the component is mounted. */
  fun componentDidMount : Promise(Never, Void) {
    sequence {
      Timer.nextFrame("")

      next { shown = true }

      Timer.timeout(duration - 520, "")

      next { shown = false }
    }
  }

  /* The click event handler. */
  fun handleClick : Promise(Never, Void) {
    next { shown = false }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::content as base onClick={handleClick}>
        <{ content }>
      </div>
    </div>
  }
}
