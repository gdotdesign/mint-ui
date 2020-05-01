component Ui.Page {
  connect Ui exposing { contentBackgroundFaded, contentText }

  property children : Array(Html) = []

  style base {
    background: #{contentBackgroundFaded};
    color: #{contentText};
    padding: 32px;
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

  fun render : Html {
    <div::base>
      <div>
        <{ header }>
      </div>

      <div>
        <{ breadcrumbs }>
      </div>

      <div::content>
        <{ content }>
      </div>
    </div>
  }
}
