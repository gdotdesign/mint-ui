/* A layout component for displaying documentation. */
component Ui.Layout.Documentation {
  connect Ui exposing { mobile }

  /* The items groupped by a string. */
  property items : Array(Ui.NavItem) = []

  /* The content to render. */
  property children : Array(Html) = []

  /* The size of the component. */
  property size : Number = 16

  /* The items for the table of contents. */
  state tocItems : Array(Tuple(String, String)) = []

  /* We are using the mutation provider to update elements on the fly. */
  use Provider.Mutation {
    changes = updateToc,
    element = content
  }

  /* The styles for the base. */
  style base {
    background: var(--content-color);
    color: var(--content-text);

    grid-template-columns: 18.75em 1fr 18.75em;
    grid-gap: 1.25em;
    display: grid;

    font-family: var(--font-family);
    font-size: #{size}px;

    if (mobile) {
      grid-template-rows: min-content 1fr;
      grid-template-columns: 1fr;
      grid-gap: 0;
    }
  }

  /* Styles for the content. */
  style content {
    min-width: 0;
  }

  /* Styles for the table of contents item. */
  style toc-item {
    text-decoration: none;
    color: inherit;

    &:hover {
      color: var(--primary-s500-color);
    }
  }

  /* Styles for the table of contents. */
  style toc {
    border-left: 0.0625em solid var(--border);
    align-self: start;

    padding: 0.3125em 1.25em;
    margin-top: 2em;

    position: sticky;
    top: 1.25em;

    grid-gap: 0.625em;
    display: grid;
  }

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

    if (active) {
      color: var(--primary-s600-color);
    }

    &:hover {
      color: var(--primary-s500-color);
    }
  }

  /* Style for the divider. */
  style divider {
    border-top: 0.125em solid var(--border);
  }

  /* Style for the mobile page selector. */
  style button {
    border-bottom: 0.0625em solid var(--border);
    display: grid;
    padding: 1em;
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

  /* Styles for the containers of items. */
  style items {
    align-content: start;
    grid-gap: 0.5em;
    display: grid;
  }

  /* Style for the items. */
  style sidebar {
    border-right: 0.0625em solid var(--border);
    padding: 2em;
  }

  /* When the component is mounted. */
  fun componentDidMount {
    /*
    Refresh the page by setting the hash, this will trigger
    the scrolling to the actual hash.
    */
    Window.triggerHashJump()
  }

  /* Gets the table of contents data of an element. */
  fun getTocData (element : Dom.Element) : Tuple(String, String) {
    {
      Maybe.withDefault("", Dom.getAttribute("name", element)),
      Dom.getTextContent(element)
    }
  }

  /* Updates the table of contents. */
  fun updateToc {
    case (content) {
      Maybe::Just element =>
        try {
          items =
            Dom.getElementsBySelector("a[name]", element)

          tocItems =
            Array.map(getTocData, items)

          next { tocItems = tocItems }
        }

      => next {  }
    }
  }

  /* Handles the click event of a table of contents item. */
  fun handleClick (event : Html.Event) {
    if (Dom.getTagName(event.target) == "A") {
      Window.triggerHashJump()
    } else {
      next {  }
    }
  }

  /* Handles the change event from the select. */
  fun handleChange (key : String) {
    try {
      path =
        Array.findByAndMap(
          (item : Ui.NavItem) {
            case (item) {
              Ui.NavItem::Link label href => {key == label, href}
              => {false, ""}
            }
          },
          items)

      case (path) {
        Maybe::Just value => Window.navigate(value)
        => next {  }
      }
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

  /* Renders an item. */
  fun renderItem (item : Ui.NavItem) : Html {
    case (item) {
      Ui.NavItem::Group iconBefore iconAfter label items =>
        <div::group>
          <strong::category::row>
            <{ renderContents(iconBefore, iconAfter, label) }>
          </strong>

          <div::items>
            for (item of items) {
              renderItem(item)
            }
          </div>
        </div>

      Ui.NavItem::Link iconBefore iconAfter label href =>
        <a::row::item(Window.url().path == href) href={href}>
          <{ renderContents(iconBefore, iconAfter, label) }>
        </a>

      Ui.NavItem::Item iconBefore iconAfter label action =>
        <div::row::item(false) onClick={action}>
          <{ renderContents(iconBefore, iconAfter, label) }>
        </div>

      Ui.NavItem::Divider => <div::divider/>
    }
  }

  /* Renders the layout. */
  fun render : Html {
    <div::base>
      if (mobile) {
        try {
          active =
            Array.findByAndMap(
              (item : Ui.NavItem) {
                case (item) {
                  Ui.NavItem::Link label href => {Window.url().path == href, label}
                  => {false, ""}
                }
              },
              items)
            |> Maybe.withDefault("")

          options =
            items
            |> Array.map(
              (item : Ui.NavItem) {
                case (item) {
                  Ui.NavItem::Link label =>
                    Ui.ListItem::Item(
                      content = <{ label }>,
                      matchString = label,
                      key = label)

                  =>
                    Ui.ListItem::Item(
                      content = <{ "" }>,
                      matchString = "",
                      key = "")
                }
              })

          <div::button>
            <Ui.Select
              onChange={handleChange}
              value={active}
              items={options}/>
          </div>
        }
      } else {
        <nav::sidebar::items>
          for (item of items) {
            renderItem(item)
          }
        </nav>
      }

      <div::content as content>
        <{ children }>
      </div>

      if (!mobile) {
        <div::toc onClick={handleClick}>
          for (item of tocItems) {
            try {
              {hash, content} =
                item

              <div>
                <a::toc-item href="##{hash}">
                  <{ content }>
                </a>
              </div>
            }
          }
        </div>
      }
    </div>
  }
}
