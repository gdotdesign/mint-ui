component Ui.Form.Field {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  property error : Maybe(String) = Maybe::Nothing
  property orientation : String = "vertical"
  property children : Array(Html) = []
  property label : String = ""

  style base {
    case (orientation) {
      "vertical" =>
        flex-direction: column-reverse;
        justify-content: flex-end;
        align-items: stretch;

      =>
        flex-direction: row;
        align-items: center;
    }

    text-align: left;
    display: flex;

    > *:first-child {
      margin-right: #{marginRight};
    }

    > *:last-child {
      margin-bottom: #{marginBottom};
    }
  }

  style error {
    color: #{actualTheme.danger.s500.color};
    font-family: #{actualTheme.fontFamily};
    font-size: 0.875em;
    font-weight: bold;
    margin-top: 5px;
  }

  get actualTheme {
    resolveTheme(theme)
  }

  get marginRight : String {
    case (orientation) {
      "horizontal" => "10px"
      => ""
    }
  }

  get marginBottom : String {
    case (orientation) {
      "vertical" => "7px"
      => ""
    }
  }

  fun render : Html {
    <div::base>
      case (error) {
        Maybe::Just message =>
          <div::error>
            <{ message }>
          </div>

        => <></>
      }

      <{ children }>

      <Ui.Form.Label
        text={label}
        fontSize={14}/>
    </div>
  }
}
