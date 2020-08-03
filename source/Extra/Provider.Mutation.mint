record Provider.Mutation.Subscription {
  changes : Function(Promise(Never, Void)),
  element : Maybe(Dom.Element)
}

provider Provider.Mutation : Provider.Mutation.Subscription {
  state observedElements : Array(Maybe(Dom.Element)) = []
  state observer = MutationObserver.new(notify)

  fun notify (entries : Array(MutationObserver.Entry)) {
    for (entry of entries) {
      for (subscription of subscriptions) {
        case (subscription.element) {
          Maybe::Just element =>
            if (Dom.contains(entry.target, element)) {
              subscription.changes()
            } else {
              next {  }
            }

          Maybe::Nothing => next {  }
        }
      }
    }
  }

  fun update : Promise(Never, Void) {
    try {
      for (element of Array.compact(observedElements)) {
        MutationObserver.unobserve(element, observer)
      }

      for (subscription of subscriptions) {
        case (subscription.element) {
          Maybe::Just element =>
            try {
              MutationObserver.observe(element, true, true, observer)
              subscription.changes()
            }

          Maybe::Nothing => next {  }
        }
      }

      next { observedElements = Array.map(.element, subscriptions) }
    }
  }
}
