component Ui.Header {
  connect Ui exposing { resolveTheme, mobile }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property items : Array(Ui.NavItem) = []
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
    outline: none;

    if (active) {
      color: #{actualTheme.primary.s500.color};
    } else {
      color: inherit;
    }

    &:hover,
    &:focus {
      color: #{actualTheme.primary.s500.color};
      text-decoration: underline;
    }
  }

  style base {
    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    font-family: #{actualTheme.fontFamily};
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
    border-left: 0.2em solid #{actualTheme.border};
    height: 2.4em;
  }

  get actualTheme {
    resolveTheme(theme)
  }

  fun handleClick {
    Ui.ActionSheet.show(items)
  }

  fun renderItem (iconBefore : Html, iconAfter : Html, label : String) {
    <>
      if (Html.Extra.isNotEmpty(iconBefore)) {
        <Ui.Icon
          icon={iconBefore}
          autoSize={true}/>
      }

      <{ label }>

      if (Html.Extra.isNotEmpty(iconAfter)) {
        <Ui.Icon
          icon={iconAfter}
          autoSize={true}/>
      }
    </>
  }

  fun render : Html {
    <div::base>
      <{ brand }>

      <Ui.LineGrid gap={size * 2.5}>
        if (mobile) {
          <div onClick={handleClick}>
            <Ui.Icon
              icon={Ui.Icons:THREE_BARS}
              size={size * 2}/>
          </div>
        } else {
          <>
            for (item of items) {
              case (item) {
                Ui.NavItem::Divider => <div::divider/>

                Ui.NavItem::Item iconBefore iconAfter label action =>
                  <div::item(false) onClick={action}>
                    <{ renderItem(iconBefore, iconAfter, label) }>
                  </div>

                Ui.NavItem::Link iconBefore iconAfter label href =>
                  <a::item(url == Url.parse(href)) href={href}>
                    <{ renderItem(iconBefore, iconAfter, label) }>
                  </a>
              }
            }
          </>
        }
      </Ui.LineGrid>
    </div>
  }
}
