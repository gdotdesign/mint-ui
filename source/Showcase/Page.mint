component Ui.Showcase.Page {
  property documentation : Function(Html) = () : Html { <></> }
  property properties : Function(Html) = () : Html { <></> }
  property example : Function(Html) = () : Html { <></> }
  property title : String = ""

  state tab : String = "documentation"

  style base {
    grid-template-rows: min-content min-content 1fr;
    grid-template-columns: 1fr 300px;
    box-sizing: border-box;
    grid-gap: 0 20px;
    display: grid;
  }

  style example {
    display: grid;
  }

  style form {
    width: 300px;

    > * + * {
      margin-top: 20px;
    }
  }

  style title {
    grid-column: span 2;
    margin-bottom: 20px;
    font-size: 22px;
  }

  fun render : Html {
    <div>
      <div::title>
        <{ title }>
      </div>

      try {
        items =
          [
            {
              content =
                () : Html {
                  <div::base>
                    <div::example>
                      <Ui.Showcase.Example>
                        <{ example() }>
                      </Ui.Showcase.Example>
                    </div>

                    <div::form>
                      <{ properties() }>
                    </div>
                  </div>
                },
              label = "Playground",
              key = "details"
            },
            {
              content = documentation,
              label = "Documentation",
              key = "documentation"
            }
          ]

        <Ui.Tabs
          onChange={(key : String) : Promise(Never, Void) { next { tab = key } }}
          selected={tab}
          items={items}/>
      }
    </div>
  }
}
