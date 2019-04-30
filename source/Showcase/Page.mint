component Ui.Showcase.Page {
  property children : Array(Html) = []
  property title : String = ""

  style base {
    padding: 20px;
  }

  style example {
    display: flex;
  }

  style form {
    width: 300px;
    padding: 0 20px;

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

  fun render : Html {
    <div::base>
      <div::title>
        <{ title }>
      </div>

      <div::example>
        <Ui.Showcase.Example>
          <{ example }>
        </Ui.Showcase.Example>

        <div::form>
          <Ui.Showcase.Header>
            "Properties"
          </Ui.Showcase.Header>

          <{ Array.drop(1, children) }>
        </div>
      </div>
    </div>
  }
}
