record Storybook.Log {
  message : String,
  time : Time
}

component Ui.Showcase.Page {
  property properties : Function(Html) = () : Html { <></> }
  property children : Array(Html) = []
  property code : String = ""
  property title : String = ""

  state logs : Array(Storybook.Log) = []
  state tab : String = "code"

  style base {
    grid-template-rows: min-content min-content 1fr;
    grid-template-columns: 1fr 300px;
    box-sizing: border-box;
    grid-gap: 0 20px;
    display: grid;
    padding: 20px;
  }

  style example {
    display: flex;
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

  get example : Html {
    Array.first(children)
    |> Maybe.withDefault(Html.empty())
  }

  fun log (message : String) : Promise(Never, Void) {
    next
      {
        logs =
          Array.push({
            message = message,
            time = Time.now()
          }, logs)
      }
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

      <div::form>
        <{ properties() }>
      </div>

      <Ui.Tabs
        onChange={(key : String) : Promise(Never, Void) { next { tab = key } }}
        selected={tab}
        items=[
          {
            content =
              () : Html {
                <pre>
                  <{ code }>
                </pre>
              },
            label = "Code",
            key = "code"
          },
          {
            content =
              () : Html {
                <>
                  for (log of logs) {
                    <div>
                      <{ Time.format("", log.time) }>
                      <{ log.message }>
                    </div>
                  }
                </>
              },
            label = "Logs",
            key = "logs"
          }
        ]/>
    </div>
  }
}
