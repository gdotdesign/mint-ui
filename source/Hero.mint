component Ui.Hero {
  connect Ui exposing { contentBackground, contentText, fontFamily, mobile }

  property subtitle : Html = <></>
  property action : Html = <></>
  property title : Html = <></>

  style base {
    justify-content: center;
    flex-direction: column;
    align-items: center;
    display: flex;

    font-family: #{fontFamily};
    background: #{contentBackground};
    color: #{contentText};
    padding: 0 30px;
  }

  style subtitle {
    text-align: center;
    margin-bottom: 36px;
    font-size: 22px;

    if (mobile) {
      font-size: 16px;
    }
  }

  style title {
    text-align: center;
    font-weight: bold;
    font-size: 36px;
    margin-bottom: 20px;

    if (mobile) {
      font-size: 22px;
    }
  }

  style action {
    grid-gap: 20px;
    display: grid;

    if (mobile) {
      grid-auto-flow: row;
    } else {
      grid-auto-flow: column;
    }
  }

  fun render : Html {
    <div::base>
      <div::title>
        <{ title }>
      </div>

      <div::subtitle>
        <{ subtitle }>
      </div>

      <div::action>
        <{ action }>
      </div>
    </div>
  }
}
