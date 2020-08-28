/*
This component makes possible to have arbitrary HTML content which behaves
like static content:

- tab focus is disabled by adding `tabindex="-1"` to all child elements
- pointer focus is disabled with the `pointer-events: none` CSS.
- all elements are hidden from screen readers
*/
component Ui.AvoidFocus {
  /* The child elements. */
  property children : Array(Html) = []

  /* Wether or not to disable cursor events as well. */
  property disableCursor : Bool = true

  /* We are using the mutation provider to update elements on the fly. */
  use Provider.Mutation {
    changes = update,
    element = base
  }

  /* Style for the base element. */
  style base {
    if (disableCursor) {
      pointer-events: none;
    }

    * {
      outline: none !important;
    }
  }

  /* Sets `tabindex="-1"` on all child elements. */
  fun update : Promise(Never, Void) {
    try {
      case (base) {
        Maybe::Just element =>
          for (element of Dom.getElementsBySelector("*", element)) {
            Dom.setAttribute("tabindex", "-1", element)
          }

        Maybe::Nothing => []
      }

      next {  }
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base as base aria-hidden="true">
      <{ children }>
    </div>
  }
}
