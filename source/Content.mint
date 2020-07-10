/*
A component to display content:

- headings
- paragraphs
- ordered and unordered lists
- images
- preformatted text (such as code)
*/
component Ui.Content {
  connect Ui exposing { resolveTheme, mobile }

  /* The theme for the content. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The children to display. */
  property children : Array(Html) = []

  /* Where to align the text. */
  property textAlign : String = ""

  /* Wether or not to add a padding to the content. */
  property padding : Bool = false

  /* The size of the checkbox. */
  property size : Number = 16

  /* The styles for the contents. */
  style base {
    font-family: #{actualTheme.fontFamily};
    text-align: #{textAlign};
    font-size: #{size}px;
    line-height: 1.7em;

    if (padding && mobile) {
      padding: 1em;
    } else if (padding) {
      padding: 2em;
    } else {
      padding: 0;
    }

    > *:first-child {
      margin-top: 0;
    }

    > *:last-child {
      margin-bottom: 0;
    }

    h1,
    h2,
    h3,
    h4,
    h5 {
      line-height: 1.2em;
    }

    h2 {
      margin-top: 2em;
    }

    li + li {
      margin-top: 0.5em;
    }

    a:not([name]):not([class]) {
      color: #{actualTheme.primary.s500.color};
    }

    code {
      background: #{actualTheme.contentFaded.color};
      color: #{actualTheme.contentFaded.text};

      border: 0.0625em solid #{actualTheme.border};
      border-radius: 0.125em;

      padding: 0.125em 0.375em 0;
      display: inline-block;

      font-size: 0.875em;
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the content. */
  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
