record Provider.ElementSize.Subscription {
  changes : Function(Dom.Dimensions, Promise(Never, Void)),
  element : Maybe(Dom.Element)
}

record ResizeObserver.Entry {
  contentRect : Object,
  target : Dom.Element
}

/* A provider for global "popstate" events. */
provider Provider.ElementSize : Provider.ElementSize.Subscription {
  state observedElements : Array(Maybe(Dom.Element)) = []
  state observer = `new ResizeObserver(#{notify})`

  fun notify (entries : Array(ResizeObserver.Entry)) {
    for (entry of entries) {
      for (subscription of subscriptions) {
        case (subscription.element) {
          Maybe::Just element =>
            if (element == entry.target) {
              try {
                dimensions =
                  decode entry.contentRect as Dom.Dimensions

                subscription.changes(dimensions)
              } catch {
                next {  }
              }
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
        `#{observer}.unobserve(#{element})`
      }

      for (subscription of subscriptions) {
        case (subscription.element) {
          Maybe::Just element => `#{observer}.observe(#{element})`
          Maybe::Nothing => ""
        }
      }

      next { observedElements = Array.map(.element, subscriptions) }
    }
  }
}
