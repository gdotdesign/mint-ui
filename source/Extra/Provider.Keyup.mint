/* Represents a subscription for `Provider.Keyup` */
record Provider.Keyup.Subscription {
  keyups : Function(Html.Event, Promise(Never, Void))
}

/* A provider for global scroll events. */
provider Provider.Keyup : Provider.Keyup.Subscription {
  state listener : Function(Void) = () { void }

  fun handle (event : Html.Event) {
    for (subscription of subscriptions) {
      subscription.keyups(event)
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
      next { listener = Window.addEventListener("keyup", true, handle) }
    }
  }
}
