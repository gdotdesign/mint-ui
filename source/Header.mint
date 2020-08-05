/*
The header component with a brand and navigation items which on mobile collapses
into a icon which when interacted with opens up an action sheet with the
navigation items.
*/
component Ui.Header {
  connect Ui exposing { mobile }

  /* The navigation items. */
  property items : Array(Ui.NavItem) = []

  /* Content for the brand. */
  property brand : Html = <></>

  /* The menu icon. */
  property icon : Html = Ui.Icons:THREE_BARS

  /* The size of the component. */
  property size : Number = 16

  /* A state to store the current url. */
  state url : Url = Window.url()

  state openDropdowns : Map(String, Bool) = Map.empty()

  use Provider.Url { changes = (url : Url) { next { url = url } } }

  /* The style for the base. */
  style base {
    background: var(--content-color);
    color: var(--content-text);

    font-family: var(--font-family);
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

  /* The style of an item. */
  style item (active : Bool) {
    text-decoration: none;
    font-weight: bold;

    grid-auto-flow: column;
    align-items: center;
    grid-gap: 0.5em;
    display: grid;
    outline: none;

    cursor: pointer;

    if (active) {
      color: var(--primary-s500-color);
    } else {
      color: inherit;
    }

    &:hover,
    &:focus {
      color: var(--primary-s500-color);
      text-decoration: underline;
    }
  }

  /* The style for the divider. */
  style divider {
    border-left: 0.2em solid var(--border);
    height: 2.4em;
  }

  /* The menu icon click handler. */
  fun handleClick : Promise(Never, Void) {
    Ui.ActionSheet.show(items)
  }

  /* Renders the contents of an item. */
  fun renderItem (iconBefore : Html, iconAfter : Html, label : String) {
    <>
      if (Html.isNotEmpty(iconBefore)) {
        <Ui.Icon
          icon={iconBefore}
          autoSize={true}/>
      }

      <{ label }>

      if (Html.isNotEmpty(iconAfter)) {
        <Ui.Icon
          icon={iconAfter}
          autoSize={true}/>
      }
    </>
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <{ brand }>

      <Ui.LineGrid gap={size * 2.5}>
        if (mobile) {
          <div onClick={handleClick}>
            <Ui.Icon
              size={size * 2}
              icon={icon}/>
          </div>
        } else {
          <{
            for (item of items) {
              case (item) {
                Ui.NavItem::Divider => <div::divider/>

                Ui.NavItem::Group iconBefore iconAfter label key =>
                  try {
                    open =
                      Map.getWithDefault(key, false, openDropdowns)

                    <Ui.Dropdown
                      onClose={() { next { openDropdowns = Map.set(key, false, openDropdowns) } }}
                      closeOnOutsideClick={true}
                      position="bottom-right"
                      offset={15}
                      open={open}
                      element={
                        <div::item(false)
                          tabIndex="0"
                          onFocus={() { next { openDropdowns = Map.set(key, true, openDropdowns) } }}
                          onBlur={() { next { openDropdowns = Map.set(key, false, openDropdowns) } }}
                          onClick={() { next { openDropdowns = Map.set(key, true, openDropdowns) } }}>

                          <{ renderItem(iconBefore, iconAfter, label) }>

                        </div>
                      }
                      content={
                        <Ui.Dropdown.Panel>
                          "Content"
                        </Ui.Dropdown.Panel>
                      }/>
                  }

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
          }>
        }
      </Ui.LineGrid>
    </div>
  }
}
