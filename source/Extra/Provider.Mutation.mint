record Provider.Mutation.Subscription {
  changes : Function(Promise(Never, Void)),
  element : Maybe(Dom.Element)
}

record MutationObserver.Entry {
  target : Dom.Element,
  type : String
}

provider Provider.Mutation : Provider.Mutation.Subscription {
  state observedElements : Array(Maybe(Dom.Element)) = []
  state observer = `new MutationObserver(#{notify})`

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
        `#{observer}.disconnect(#{element})`
      }

      for (subscription of subscriptions) {
        case (subscription.element) {
          Maybe::Just element =>
            try {
              `#{observer}.observe(#{element}, {subtree: true, childList: true})`
              subscription.changes()
            }

          Maybe::Nothing => next {  }
        }
      }

      next { observedElements = Array.map(.element, subscriptions) }
    }
  }
}
