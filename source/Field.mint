/* A form field component. */
component Ui.Field {
  /* The error message. */
  property error : Maybe(String) = Maybe::Nothing

  /* The orientation either `vertical` or `horizontal`. */
  property orientation : String = "vertical"

  /* The label to display. */
  property label : String = ""

  /* The children to render. */
  property children : Array(Html) = []

  /* The style for the base. */
  style base {
    text-align: left;
    grid-gap: 0.25em;
    display: grid;
  }

  /* The style for the control. */
  style control {
    case (orientation) {
      "horizontal" =>
        justify-content: start;
        grid-auto-flow: column;
        align-items: center;
        grid-gap: 0.5em;

      =>
        align-content: start;
        grid-gap: 0.375em;
    }

    display: grid;
  }

  /* The style for the error message. */
  style error {
    font-family: var(--font-family);
    color: var(--danger-s500-color);

    font-size: 0.875em;
    font-weight: bold;
  }

  /* The style for the label. */
  style label {
    font-family: var(--font-family);
    color: var(--content-text);

    font-size: 0.875em;
    font-weight: bold;

    white-space: nowrap;
    line-height: 1;

    flex: 0 0 auto;
    opacity: 0.8;
  }

  fun render : Html {
    <div::base>
      <div::control>
        case (orientation) {
          "horizontal" =>
            <{
              <div>
                <{ children }>
              </div>

              <div::label>
                <{ label }>
              </div>
            }>

          =>
            <{
              <div::label>
                <{ label }>
              </div>

              <div>
                <{ children }>
              </div>
            }>
        }
      </div>

      case (error) {
        Maybe::Just message =>
          <div::error>
            <{ message }>
          </div>

        => <{  }>
      }
    </div>
  }
}
