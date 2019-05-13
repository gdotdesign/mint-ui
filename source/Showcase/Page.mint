component Ui.Showcase.Page {
  property children : Array(Html) = []
  property title : String = ""
  property properties : Function(Html) = () : Html { <></> }

  state logs : Array(String) = []
  state tab : String = "properties"

  style base {
    padding: 20px;
  }

  style example {
    display: flex;
  }

  style form {
    width: 300px;

    & > * + * {
      margin-top: 20px;
    }
  }

  style title {
    padding: 12px 20px;
    font-size: 22px;
  }

  get example : Html {
    Array.first(children)
    |> Maybe.withDefault(Html.empty())
  }

  fun log (message : String) : Promise(Never, Void) {
    next { logs = Array.push(message, logs) }
  }

  fun render : Html {
    <div::base>
      <div::title>
        <{ title }>
      </div>

      <div::example>
        <Ui.Showcase.Example>
          <{ example }>
        </Ui.Showcase.Example>
      </div>

      <Ui.Tabs
        onChange={(key : String) : Promise(Never, Void) { next { tab = key } }}
        selected={tab}
        items=[
          {
            content =
              () : Html {
                <Ui.ScrollPanel>
                  <div::form>
                    <{ properties() }>
                  </div>
                </Ui.ScrollPanel>
              },
            label = "Properties",
            key = "properties"
          },
          {
            content =
              () : Html {
                <>
                  for (log of logs) {
                    <div>
                      <{ log }>
                    </div>
                  }
                </>
              },
            label = "Logs",
            key = "logs"
          },
          {
            content =
              () : Html {
                <>
                  "CODE"
                </>
              },
            label = "Code",
            key = "code"
          }
        ]/>
    </div>
  }
}
