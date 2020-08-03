/* A simple hero component with an image, title, subtitle and actions. */
component Ui.Hero {
  connect Ui exposing { resolveTheme, mobile }

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The content for the subtitle. */
  property subtitle : Html = <></>

  /* The content for the actions. */
  property actions : Html = <></>

  /* The content for the title. */
  property title : Html = <></>

  /* The size of the component. */
  property size : Number = 16

  /* The styles for the base. */
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

  /* The styles for the subtitle. */
  style subtitle {
    margin-bottom: 2.25em;
    text-align: center;

    if (mobile) {
      font-size: 1em;
    } else {
      font-size: 1.375em;
    }
  }

  /* The styles for the title. */
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

  /* The styles for the actions. */
  style actions {
    grid-gap: 1em;
    display: grid;

    if (mobile) {
      grid-auto-flow: row;
    } else {
      grid-auto-flow: column;
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      if (Html.isNotEmpty(title)) {
        <div::title>
          <{ title }>
        </div>
      }

      if (Html.isNotEmpty(subtitle)) {
        <div::subtitle>
          <{ subtitle }>
        </div>
      }

      if (Html.isNotEmpty(actions)) {
        <div::actions>
          <{ actions }>
        </div>
      }
    </div>
  }
}
