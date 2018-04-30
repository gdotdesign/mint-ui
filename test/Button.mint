record Tests.Ui.Button {
  text : String
}

component Tests.Ui.Button {
  state : Tests.Ui.Button { text = "Hello" }

  fun render : Html {
    <Ui.Button
      onMouseDown={\event : Html.Event => next { state | text = "MouseDown" }}
      onClick={\event : Html.Event => next { state | text = "Click" }}
      label={state.text}/>
  }
}

suite "Ui.Button" {
  test "set the background color for primary" {
    with Test.Html {
      <Ui.Button/>
      |> start()
      |> assertCSSOf("button", "background-color", "rgb(58, 173, 87)")
    }
  }

  test "set the background color for secondary" {
    with Test.Html {
      <Ui.Button type="secondary"/>
      |> start()
      |> assertCSSOf("button", "background-color", "rgb(34, 34, 34)")
    }
  }

  test "renders the icon" {
    with Test.Html {
      <Ui.Button icon={<i/>}/>
      |> start()
      |> assertElementExists("i")
    }
  }

  test "renders the label" {
    with Test.Html {
      <Ui.Button label="Hello"/>
      |> start()
      |> assertTextOf("button", "Hello")
    }
  }

  test "handles click events" {
    with Test.Html {
      <Tests.Ui.Button/>
      |> start()
      |> assertTextOf("button", "Hello")
      |> triggerClick("button")
      |> assertTextOf("button", "Click")
    }
  }

  test "handles mouse down events" {
    with Test.Html {
      <Tests.Ui.Button/>
      |> start()
      |> assertTextOf("button", "Hello")
      |> triggerMouseDown("button")
      |> assertTextOf("button", "MouseDown")
    }
  }
}
