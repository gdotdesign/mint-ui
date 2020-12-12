/* A component to render a navigation item (on desktop). */
component Ui.NavItem {
  state url : Url = Window.url()

  use Provider.Url { changes = (url : Url) { next { url = url } } }

  /* The navigation item. */
  property item : Ui.NavItem

  /* Style for a category. */
  style category {
    margin-bottom: 0.3125em;
    display: block;

    &:not(:first-child) {
      margin-top: 1.25em;
    }
  }

  /* Styles for a row. */
  style row {
    grid-auto-flow: column;
    justify-content: start;
    align-items: center;
    grid-gap: 0.75em;
    display: grid;
  }

  /* Style for an item in the sidebar. */
  style item (active : Bool) {
    text-decoration: none;
    cursor: pointer;
    color: inherit;
    outline: none;

    if (active) {
      color: var(--primary-s600-color);
    }

    &:hover,
    &:focus {
      color: var(--primary-s500-color);
    }
  }

  /* Style for the divider. */
  style divider {
    border-top: 0.125em solid var(--border);
  }

  /* Styles for the group. */
  style group {
    margin-bottom: 0.5em;

    > div {
      padding-left: 0.75em;
      border-left: 1px solid var(--border);
    }

    strong {
      margin-bottom: 0.5em;
    }

    &:not(:first-child) {
      margin-top: 0.5em;
    }
  }

  /* Renders the contents of an item. */
  fun renderContents (iconBefore : Html, iconAfter : Html, label : String) {
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

  /* Renders the item. */
  fun render : Html {
    case (item) {
      Ui.NavItem::Group iconBefore iconAfter label items =>
        <div::group>
          <strong::category::row>
            <{ renderContents(iconBefore, iconAfter, label) }>
          </strong>

          <Ui.NavItems items={items}/>
        </div>

      Ui.NavItem::Link iconBefore iconAfter label href =>
        <a::row::item(url == Url.parse(href)) href={href}>
          <{ renderContents(iconBefore, iconAfter, label) }>
        </a>

      Ui.NavItem::Item iconBefore iconAfter label action =>
        <div::row::item(false) onClick={action}>
          <{ renderContents(iconBefore, iconAfter, label) }>
        </div>

      Ui.NavItem::Divider => <div::divider/>
    }
  }
}
