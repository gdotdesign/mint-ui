/* A form field component. */
component Ui.Form.Field {
  connect Ui exposing { resolveTheme }

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

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
    color: #{actualTheme.danger.s500.color};
    font-family: #{actualTheme.fontFamily};
    font-size: 0.875em;
    font-weight: bold;
  }

  /* The style for the label. */
  style label {
    font-family: #{actualTheme.fontFamily};
    font-size: 0.875em;

    color: #{actualTheme.content.text};

    white-space: nowrap;
    font-weight: bold;
    line-height: 1;
    flex: 0 0 auto;
    opacity: 0.8;
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  fun render : Html {
    <div::base>
      <div::control>
        case (orientation) {
          "horizontal" =>
            <{
              <div key="control">
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

              <div key="control">
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
