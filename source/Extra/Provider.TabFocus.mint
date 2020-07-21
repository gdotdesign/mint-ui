record Provider.TabFocus.Subscription {
  onTabOut : Function(Promise(Never, Void)),
  onTabIn : Function(Promise(Never, Void)),
  element : Maybe(Dom.Element)
}

provider Providers.TabFocus : Provider.TabFocus.Subscription {
  state keyDownListener : Function(Void) = () { void }
  state keyUpListener : Function(Void) = () { void }

  fun handleKeyUp (event : Html.Event) {
    if (event.keyCode == 9) {
      try {
        activeElement =
          Dom.Extra.getActiveElement()

        for (subscription of subscriptions) {
          subscription.onTabIn()
        } when {
          subscription.element == activeElement
        }
      }
    } else {
      []
    }
  }

  fun handleKeyDown (event : Html.Event) {
    if (event.keyCode == 9) {
      try {
        target =
          Maybe::Just(event.target)

        for (subscription of subscriptions) {
          subscription.onTabOut()
        } when {
          subscription.element == target
        }
      }
    } else {
      []
    }
  }

  /* Updates the provider. */
  fun update : Promise(Never, Void) {
    if (Array.isEmpty(subscriptions)) {
      try {
        keyDownListener()
        keyUpListener()

        next
          {
            keyDownListener = () { void },
            keyUpListener = () { void }
          }
      }
    } else {
      next
        {
          keyDownListener = Window.addEventListener("keydown", true, handleKeyDown),
          keyUpListener = Window.addEventListener("keyup", true, handleKeyUp)
        }
    }
  }
}
