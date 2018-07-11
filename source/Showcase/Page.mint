component Ui.Showcase.Page {
  property children : Array(Html) = []
  property title : String = ""

  style base {
    border-bottom: 1px solid rgba(0,0,0,.1);
    background: #F5F5F5;
  }

  style example {
    display: flex;
  }

  style form {
    border-left: 1px solid rgba(0,0,0,.1);
    min-width: 300px;

    & > * {
      padding: 10px 15px;
    }

    & > * + * {
      border-top: 1px solid rgba(0,0,0,.1);
    }
  }

  style title {
    border-bottom: 1px solid rgba(0,0,0,.1);
    padding: 12px 20px;
    font-size: 22px;
  }

  get example : Html {
    Array.first(children)
    |> Maybe.withDefault(Html.empty())
  }

  get fields : Array(Html) {
    children
    |> Array.slice(1, Array.size(children))
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
            <{ "Properties" }>
          </Ui.Showcase.Header>

          <{ fields }>
        </div>
      </div>
    </div>
  }
}
