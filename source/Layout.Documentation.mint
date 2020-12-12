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

  /* Style for the mobile page selector. */
  style button {
    position: sticky;
    margin-left: 1em;
    bottom: 1em;
    z-index: 1;
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
  fun openActionSheet : Promise(Never, Void) {
    Ui.ActionSheet.show(items)
  }

  /* Renders the layout. */
  fun render : Html {
    <div::base>
      if (!mobile) {
        <nav::sidebar>
          <Ui.NavItems items={items}/>
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
      } else {
        <div::button>
          <Ui.FloatingButton
            icon={Ui.Icons:THREE_BARS}
            onClick={openActionSheet}
            type="surface"/>
        </div>
      }
    </div>
  }
}
