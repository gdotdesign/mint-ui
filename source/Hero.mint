component Ui.Hero {
  connect Ui exposing { resolveTheme, mobile }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property subtitle : Html = <></>
  property action : Html = <></>
  property title : Html = <></>
  property size : Number = 16

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    justify-content: center;
    flex-direction: column;
    align-items: center;
    display: flex;

    background: #{actualTheme.content.color};
    font-family: #{actualTheme.fontFamily};
    color: #{actualTheme.content.text};
    font-size: #{size}px;

    if (mobile) {
      padding: 1em;
    } else {
      padding: 2em;
    }
  }

  style subtitle {
    margin-bottom: 2.25em;
    text-align: center;

    if (mobile) {
      font-size: 1em;
    } else {
      font-size: 1.375em;
    }
  }

  style title {
    margin-bottom: 1.25em;
    text-align: center;
    font-weight: bold;

    if (mobile) {
      font-size: 1.375em;
    } else {
      font-size: 2.25em;
    }
  }

  style action {
    grid-gap: 1em;
    display: grid;

    if (mobile) {
      grid-auto-flow: row;
    } else {
      grid-auto-flow: column;
    }
  }

  fun render : Html {
    <div::base>
      if (Html.Extra.isNotEmpty(title)) {
        <div::title>
          <{ title }>
        </div>
      }

      if (Html.Extra.isNotEmpty(subtitle)) {
        <div::subtitle>
          <{ subtitle }>
        </div>
      }

      if (Html.Extra.isNotEmpty(action)) {
        <div::action>
          <{ action }>
        </div>
      }
    </div>
  }
}
