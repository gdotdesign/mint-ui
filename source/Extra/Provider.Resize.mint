record Provider.ElementSize.Subscription {
  changes : Function(Dom.Dimensions, Promise(Never, Void)),
  element : Maybe(Dom.Element)
}

/* A provider for global "popstate" events. */
provider Provider.ElementSize : Provider.ElementSize.Subscription {
  state observedElements : Array(Maybe(Dom.Element)) = []
  state observer = ResizeObserver.new(notify)

  fun notify (entries : Array(ResizeObserver.Entry)) {
    for (entry of entries) {
      for (subscription of subscriptions) {
        case (subscription.element) {
          Maybe::Just element =>
            if (element == entry.target) {
              subscription.changes(entry.dimensions)
            } else {
              next {  }
            }

          Maybe::Nothing => next {  }
        }
      }
    }
  }

  /* Updates the provider. */
  fun update : Promise(Never, Void) {
    try {
      for (element of Array.compact(observedElements)) {
        ResizeObserver.unobserve(element, observer)
      }

      for (subscription of subscriptions) {
        case (subscription.element) {
          Maybe::Just element =>
            try {
              ResizeObserver.observe(element, observer)
              void
            }

          Maybe::Nothing => void
        }
      }

      next { observedElements = Array.map(.element, subscriptions) }
    }
  }
}
