/* Represents a subscription for `Provider.Keydown` */
record Provider.Keydown.Subscription {
  keydowns : Function(Html.Event, Promise(Never, Void))
}

/* A provider for global scroll events. */
provider Provider.Keydown : Provider.Keydown.Subscription {
  state listener : Function(Void) = () { void }

  fun handleKeyDown (event : Html.Event) {
    for (subscription of subscriptions) {
      subscription.keydowns(event)
    }
  }

  /* Updates the provider. */
  fun update : Promise(Never, Void) {
    if (Array.isEmpty(subscriptions)) {
      try {
        listener()

        next { listener = () { void } }
      }
    } else {
      next { listener = Window.addEventListener("keydown", true, handleKeyDown) }
    }
  }
}
