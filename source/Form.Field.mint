component Ui.Form.Field {
  property orientation : String = "vertical"
  property children : Array(Html) = []
  property label : String = ""

  style base {
    flex-direction: #{flexDirection};
    align-items: #{alignItems};
    display: flex;

    > *:first-child {
      margin-right: #{marginRight};
    }

    > *:last-child {
      margin-bottom: #{marginBottom};
    }
  }

  get marginRight : String {
    case (orientation) {
      "horizontal" => "10px"
      => ""
    }
  }

  get marginBottom : String {
    case (orientation) {
      "vertical" => "5px"
      => ""
    }
  }

  get alignItems : String {
    case (orientation) {
      "horizontal" => "center"
      => ""
    }
  }

  get flexDirection : String {
    case (orientation) {
      "vertical" => "column-reverse"
      => "row"
    }
  }

  get labelSize : Number {
    case (orientation) {
      "vertical" => 14
      => 16
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>

      <Ui.Form.Label
        text={label}
        fontSize={labelSize}/>
    </div>
  }
}
