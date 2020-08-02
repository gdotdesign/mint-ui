record Provider.OutsideClick.Subscription {
  clicks : Function(Promise(Never, Void)),
  element : Maybe(Dom.Element)
}

provider Provider.OutsideClick : Provider.OutsideClick.Subscription {
  state listener : Function(Void) = () { void }

  fun handle (event : Html.Event) {
    for (subscription of subscriptions) {
      case (subscription.element) {
        Maybe::Just item =>
          if (Dom.contains(event.target, item)) {
            Promise.never()
          } else {
            subscription.clicks()
          }

        => Promise.never()
      }
    }
  }

  fun update : Promise(Never, Void) {
    if (Array.isEmpty(subscriptions)) {
      try {
        listener()

        next { listener = () { void } }
      }
    } else {
      next { listener = Window.addEventListener("mouseup", true, handle) }
    }
  }
}
