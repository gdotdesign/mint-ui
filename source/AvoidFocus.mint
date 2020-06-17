component Ui.AvoidFocus {
  property children : Array(Html) = []

  use Provider.Mutation {
    changes = update,
    element = base
  }

  style base {
    pointer-events: none;
  }

  fun update {
    `
    (() => {
      for (let element of #{base}._0.querySelectorAll('*')) {
        element.tabIndex = -1
      }
    })()
    `
  }

  fun render : Html {
    <div::base as base>
      <{ children }>
    </div>
  }
}
