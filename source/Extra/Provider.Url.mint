/* Represents a subscription for `Provider.Pointer` */
record Provider.Url.Subscription {
  changes : Function(Url, Promise(Never, Void))
}

/* A provider for global "popstate" events. */
provider Provider.Url : Provider.Url.Subscription {
  state listener : Function(Void) = () { void }

  fun handlePopstate (event : Html.Event) {
    try {
      url =
        Window.url()

      for (subscription of subscriptions) {
        subscription.changes(url)
      }
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
      next { listener = Window.addEventListener("popstate", false, handlePopstate) }
    }
  }
}
