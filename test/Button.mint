record Tests.Ui.Button {
  text : String
}

component Tests.Ui.Button {
  state text : String = "Hello"

  fun render : Html {
    <Ui.Button
      onMouseDown={(event : Html.Event) : Promise(Never, Void) { next { text = "MouseDown" } }}
      onClick={(event : Html.Event) : Promise(Never, Void) { next { text = "Click" } }}>

      <{ text }>

    </Ui.Button>
  }
}

suite "Ui.Button" {
  test "set the background color for secondary" {
    with Test.Html {
      <Ui.Button type="secondary"/>
      |> start()
      |> assertCSSOf("button", "background-color", "rgb(34, 34, 34)")
    }
  }

  test "renders the label" {
    with Test.Html {
      <Ui.Button>
        "Hello"
      </Ui.Button>
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
