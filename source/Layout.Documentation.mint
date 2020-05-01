component Ui.Layout.Documentation {
  connect Ui exposing { surfaceBackground, fontFamily, contentBackground, contentText }

  property items : Array(Ui.Item) = []
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
    padding: 20px;
    min-width: 0;
  }

  style h2 {
    font-family: #{fontFamily};
    text-decoration: none;
    color: inherit;
  }

  style toc {
    border-left: 1px solid #{surfaceBackground};
    align-self: start;

    padding: 5px 20px;
    margin-top: 20px;

    position: sticky;
    top: 20px;

    grid-gap: 10px;
    display: grid;

    font-family: #{fontFamily};
  }

  style item {
    display: block;
    text-decoration: none;
    color: inherit;
  }

  style items {
    border-right: 1px solid #{surfaceBackground};
    font-family: #{fontFamily};
    padding: 20px;
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
            |> Debug.log()

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
      <div::items>
        for (item of items) {
          <a::item href={item.href}>
            <{ item.name }>
          </a>
        }
      </div>

      <div::content as content>
        <Ui.Content>
          <{ children }>
        </Ui.Content>
      </div>

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
    </div>
  }
}
