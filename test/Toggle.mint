suite "Ui.Toggle" {
  test "triggers change event" {
    try {
      handler =
        (event : Bool) { Promise.never() }
        |> Test.Extra.spyOn()

      with Test.Html {
        <Ui.Toggle onChange={handler}/>
        |> start()
        |> triggerClick("button")
        |> Test.Extra.assertFunctionCalled(handler)
      }
    }
  }
}

suite "Ui.Toggle - Disabled" {
  test "does not trigger change event" {
    with Test.Html {
      try {
        handler =
          (event : Bool) { Promise.never() }
          |> Test.Extra.spyOn()

        with Test.Html {
          <Ui.Toggle
            onChange={handler}
            disabled={true}/>
          |> start()
          |> triggerClick("button")
          |> Test.Extra.assertFunctionNotCalled(handler)
        }
      }
    }
  }
}
