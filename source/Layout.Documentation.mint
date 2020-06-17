component Ui.Layout.Documentation {
  connect Ui exposing { mobile, resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property items : Array(Tuple(String, Array(Tuple(String, String)))) = []
  property children : Array(Html) = []

  state tocItems : Array(Tuple(String, String)) = []

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    grid-template-columns: 300px 1fr 300px;
    grid-gap: 20px;
    display: grid;

    if (mobile) {
      grid-template-columns: 1fr;
    }
  }

  style content {
    min-width: 0;
  }

  style h2 {
    font-family: #{actualTheme.fontFamily};
    text-decoration: none;
    color: inherit;
  }

  style toc {
    border-left: 1px solid #{actualTheme.border};
    align-self: start;

    padding: 5px 20px;
    margin-top: 30px;

    position: sticky;
    top: 20px;

    grid-gap: 10px;
    display: grid;

    font-family: #{actualTheme.fontFamily};
  }

  style category {
    margin-bottom: 5px;
    display: block;

    &:not(:first-child) {
      margin-top: 20px;
    }
  }

  style item (active : Bool) {
    padding: 5px 0;
    display: block;
    text-decoration: none;
    color: inherit;

    if (active) {
      color: #{actualTheme.primary.s400.color};
    }
  }

  style button {
    padding: 16px;
    display: grid;
  }

  style items {
    border-right: 1px solid #{actualTheme.border};
    font-family: #{actualTheme.fontFamily};
    padding: 30px 32px;
  }

  fun componentDidMount {
    sequence {
      update()
      Window.Extra.refreshHash()
    }
  }

  fun componentDidUpdate {
    update()
  }

  fun update {
    case (content) {
      Maybe::Just element =>
        try {
          items =
            Dom.Extra.getElementsBySelector("a[name]", element)
            |> Array.map(
              (item : Dom.Element) { {Dom.Extra.getAttribute("name", item), Dom.Extra.getTextContent(item)} })

          next { tocItems = items }
        }

      => next {  }
    }
  }

  fun handleClick (event : Html.Event) {
    if (Dom.Extra.getTagName(event.target) == "A") {
      Window.Extra.refreshHash()
    } else {
      next {  }
    }
  }

  fun render : Html {
    <div::base>
      if (mobile) {
        try {
          active =
            items
            |> Array.map(
              (item : Tuple(String, Array(Tuple(String, String)))) {
                try {
                  {category, subitems} =
                    item

                  subitems
                  |> Array.map(
                    (subItem : Tuple(String, String)) {
                      try {
                        {path, name} =
                          subItem

                        if (Window.url().path == path) {
                          Maybe::Just(name)
                        } else {
                          Maybe::Nothing
                        }
                      }
                    })
                }
              })
            |> Array.concat
            |> Array.compact
            |> Array.first
            |> Maybe.withDefault("")

          <div::button>
            <Ui.Button
              align="start"
              label={active}
              type="surface"
              iconAfter="chevron-down"/>
          </div>
        }
      } else {
        <nav::items>
          for (item of items) {
            try {
              {category, subitems} =
                item

              <>
                <strong::category>
                  <{ category }>
                </strong>

                for (item of subitems) {
                  try {
                    {path, name} =
                      item

                    <a::item(Window.url().path == path) href={path}>
                      <{ name }>
                    </a>
                  }
                }
              </>
            }
          }
        </nav>
      }

      <div::content as content>
        <Ui.Content padding={true}>
          <{ children }>
        </Ui.Content>
      </div>

      if (!mobile) {
        <div::toc onClick={handleClick}>
          for (item of tocItems) {
            try {
              {hash, content} =
                item

              <div>
                <a::h2 href="##{hash}">
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
