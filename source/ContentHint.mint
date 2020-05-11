component Ui.ContentHint {
  connect Ui exposing {
    contentBackgroundFaded,
    primaryBackground,
    warningBackground,
    successBackground,
    dangerBackground
  }

  property children : Array(Html) = []
  property icon : String = ""
  property type : String = ""

  style base {
    grid-template-columns: min-content 1fr;
    align-items: center;
    grid-gap: 1.4em;
    display: grid;

    background: #{contentBackgroundFaded};
    border-left: 0.25em solid #{color};

    line-height: 150%;
    padding: 1.25em;
    margin: 1em 0;
  }

  style icon {
    color: #{color};
    font-size: 1.6em;
  }

  get color {
    case (type) {
      "primary" => primaryBackground
      "warning" => warningBackground
      "success" => successBackground
      "danger" => dangerBackground
      => ""
    }
  }

  fun render : Html {
    <div::base>
      <div::icon>
        <Ui.Icon
          autoSize={true}
          name={icon}/>
      </div>

      <div>
        <{ children }>
      </div>
    </div>
  }
}
