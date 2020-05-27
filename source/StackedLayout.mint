component Ui.Page {
  connect Ui exposing { mobile, contentBackground, contentText }

  property children : Array(Html) = []

  style base {
    background: #{contentBackground};
    color: #{contentText};

    if (mobile) {
      padding: 16px;
    } else {
      padding: 32px;
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

component Ui.CenteredPage {
  connect Ui exposing { contentBackground, contentText, mobile }

  property children : Array(Html) = []

  style base {
    background: #{contentBackground};
    color: #{contentText};

    justify-content: center;
    flex-direction: column;
    align-items: center;
    display: flex;

    if (mobile) {
      padding: 16px;
    } else {
      padding: 32px;
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

/*
A layout which fills the screen and contains
a header, breadcrumbs and content.
*/
component Ui.StackedLayout {
  connect Ui exposing { borderColor }

  /* The content element. */
  property content : Html = <></>

  /* The header element. */
  property header : Html = <></>

  /* The breadcrubms element. */
  property breadcrumbs : Html = <></>

  style base {
    grid-template-rows: min-content min-content 1fr;
    min-height: 100vh;
    display: grid;
  }

  style content {
    display: grid;
  }

  style border-bottom {
    &:not(:empty) {
      border-bottom: 1px solid #{borderColor};
    }
  }

  fun render : Html {
    <div::base>
      <div::border-bottom>
        <{ header }>
      </div>

      <div::border-bottom>
        <{ breadcrumbs }>
      </div>

      <div::content>
        <{ content }>
      </div>
    </div>
  }
}
