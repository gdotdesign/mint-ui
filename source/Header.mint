component Ui.Header {
  connect Ui exposing {
    defaultTheme,
    darkMode,
    mobile
  }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property items : Array(Ui.Items) = []
  property brand : Html = <></>
  property size : Number = 16

  state url : Url = Window.url()

  use Provider.Url { changes = (url : Url) { next { url = url } } }

  style item (active : Bool) {
    text-decoration: none;
    font-weight: bold;

    grid-auto-flow: column;
    align-items: center;
    grid-gap: 0.5em;
    display: grid;

    if (active) {
      color: #{defaultTheme.primary.s500.color};
    } else {
      color: inherit;
    }
  }

  style base {
    background: #{defaultTheme.content.color(darkMode)};
    color: #{defaultTheme.content.text(darkMode)};

    font-family: #{defaultTheme.fontFamily};
    font-size: #{size}px;

    justify-content: space-between;
    grid-auto-flow: column;
    align-items: center;
    grid-gap: 1em;
    display: grid;

    if (mobile) {
      padding: 0 1em;
      height: 3em;
    } else {
      padding: 0 2em;
      height: 4em;
    }
  }

  style divider {
    border-left: 0.2em solid #{defaultTheme.border(darkMode)};
    height: 2.4em;
  }

  get actualTheme {
    Maybe.withDefault(defaultTheme, theme)
  }

  fun handleClick {
    Ui.ActionSheet.show(items)
  }

  fun render : Html {
    <div::base>
      <{ brand }>

      <Ui.LineGrid gap={size * 2.5}>
        if (mobile) {
          <div onClick={handleClick}>
            <Ui.Icon
              name="three-bars"
              size={size * 2}/>
          </div>
        } else {
          <>
            for (item of items) {
              case (item) {
                Ui.Items::Divider => <div::divider/>

                Ui.Items::Item item =>
                  <a::item(url == Url.parse(item.href)) href={item.href}>
                    if (String.Extra.isNotEmpty(item.iconBefore)) {
                      <Ui.Icon
                        name={item.iconBefore}
                        autoSize={true}/>
                    }

                    <{ item.label }>

                    if (String.Extra.isNotEmpty(item.iconAfter)) {
                      <Ui.Icon
                        name={item.iconAfter}
                        autoSize={true}/>
                    }
                  </a>
              }
            }
          </>
        }
      </Ui.LineGrid>
    </div>
  }
}

enum Ui.Items {
  Divider
  Item(Ui.Item)
}

record Ui.Item {
  iconBefore : String,
  iconAfter : String,
  label : String,
  href : String
}
