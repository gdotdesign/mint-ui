component Ui.Layout.Documentation {
  connect Ui exposing { mobile, fontFamily, contentBackground, contentText, borderColor, primaryBackground }

  property items : Array(Tuple(String, Array(Tuple(String, String)))) = []
  property children : Array(Html) = []

  state tocItems : Array(Tuple(String, String)) = []

  style base {
    background: #{contentBackground};
    color: #{contentText};

    grid-template-columns: 300px 1fr 300px;
    grid-gap: 20px;
    display: grid;
  }

  style content {
    padding: 30px 20px 100px;
    min-width: 0;
  }

  style h2 {
    font-family: #{fontFamily};
    text-decoration: none;
    color: inherit;
  }

  style toc {
    border-left: 1px solid #{borderColor};
    align-self: start;

    padding: 5px 20px;
    margin-top: 30px;

    position: sticky;
    top: 20px;

    grid-gap: 10px;
    display: grid;

    font-family: #{fontFamily};
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
      color: #{primaryBackground};
    }
  }

  style items {
    border-right: 1px solid #{borderColor};
    font-family: #{fontFamily};
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
      if (!mobile) {
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
        <Ui.Content>
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
