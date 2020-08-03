suite "Ui.Button" {
  test "renders the label" {
    with Test.Html {
      <Ui.Button label="Hello"/>
      |> start()
      |> assertTextOf("button", "Hello")
    }
  }

  test "handles click events" {
    try {
      handler =
        (event : Html.Event) { Promise.never() }
        |> Test.spyOn()

      with Test.Html {
        <Ui.Button onClick={handler}/>
        |> start()
        |> triggerClick("button")
        |> Test.assertFunctionCalled(handler)
      }
    }
  }

  test "handles mouse down events" {
    with Test.Html {
      try {
        handler =
          (event : Html.Event) { Promise.never() }
          |> Test.spyOn()

        with Test.Html {
          <Ui.Button onMouseDown={handler}/>
          |> start()
          |> triggerMouseDown("button")
          |> Test.assertFunctionCalled(handler)
        }
      }
    }
  }

  test "handles mouse up events" {
    with Test.Html {
      try {
        handler =
          (event : Html.Event) { Promise.never() }
          |> Test.spyOn()

        with Test.Html {
          <Ui.Button onMouseUp={handler}/>
          |> start()
          |> triggerMouseUp("button")
          |> Test.assertFunctionCalled(handler)
        }
      }
    }
  }
}

suite "Ui.Button - Disabled" {
  test "always renders as button" {
    with Test.Html {
      <Ui.Button
        disabled={true}
        label="Hello"
        href="/"/>
      |> start()
      |> assertTextOf("button", "Hello")
    }
  }

  test "doesn't handle click events" {
    with Test.Html {
      try {
        handler =
          (event : Html.Event) { Promise.never() }
          |> Test.spyOn()

        with Test.Html {
          <Ui.Button
            onClick={handler}
            disabled={true}/>
          |> start()
          |> triggerClick("button")
          |> Test.assertFunctionNotCalled(handler)
        }
      }
    }
  }

  test "doesn't handle mouse down events" {
    with Test.Html {
      try {
        handler =
          (event : Html.Event) { Promise.never() }
          |> Test.spyOn()

        with Test.Html {
          <Ui.Button
            onMouseDown={handler}
            disabled={true}/>
          |> start()
          |> triggerMouseDown("button")
          |> Test.assertFunctionNotCalled(handler)
        }
      }
    }
  }

  test "doesn't handle mouse up events" {
    with Test.Html {
      try {
        handler =
          (event : Html.Event) { Promise.never() }
          |> Test.spyOn()

        with Test.Html {
          <Ui.Button
            onMouseUp={handler}
            disabled={true}/>
          |> start()
          |> triggerMouseUp("button")
          |> Test.assertFunctionNotCalled(handler)
        }
      }
    }
  }
}
