/* A generic modal component. */
global component Ui.Modal {
  /* The resolve function. */
  state resolve : Function(Void, Void) = (value : Void) { void }

  /* The reject function. */
  state reject : Function(String, Void) = (error : String) { void }

  /* The theme. */
  state theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The content of the modal. */
  state content : Html = <></>

  /* The transition duration. */
  state transitionDuration : Number = 240

  /* The z-index of the modal. */
  state zIndex : Number = 100

  /* Wether or not the modal is open. */
  state open : Bool = false

  use Provider.Shortcuts {
    shortcuts =
      [
        {
          condition = () : Bool { true },
          bypassFocused = true,
          shortcut = [27],
          action = hide
        }
      ]
  }

  /* Shows the component with the given content. */
  fun show (content : Html) : Promise(String, Void) {
    showWithOptions(
      content,
      100,
      240,
      Maybe::Nothing,
      () {
        case (base) {
          Maybe::Just comp => comp.focusFirst()
          Maybe::Nothing => next {  }
        }
      })
  }

  /* Shows the component with the given content and z-index. */
  fun showWithOptions (
    content : Html,
    zIndex : Number,
    transitionDuration : Number,
    theme : Maybe(Ui.Theme),
    openCallback : Function(Promise(Never, Void))
  ) : Promise(String, Void) {
    try {
      {resolve, reject, promise} =
        Promise.create()

      next
        {
          transitionDuration = transitionDuration,
          content = content,
          resolve = resolve,
          zIndex = zIndex,
          reject = reject,
          theme = theme,
          open = true
        }

      sequence {
        Timer.timeout(transitionDuration, "")
        openCallback()
      }

      promise
    }
  }

  /* Cancels the modal. */
  fun cancel : Promise(Never, Void) {
    sequence {
      next { open = false }

      Timer.timeout(transitionDuration, "")
      reject("")

      next
        {
          reject = (error : String) { void },
          resolve = (value : Void) { void },
          content = <{  }>
        }
    }
  }

  /* Hides the modal. */
  fun hide : Promise(Never, Void) {
    sequence {
      next { open = false }

      Timer.timeout(transitionDuration, "")
      resolve(void)

      next
        {
          reject = (error : String) { void },
          resolve = (value : Void) { void }
        }
    }
  }

  /* Renders the modal. */
  fun render : Html {
    try {
      modal =
        <Ui.Modal.Base as base
          content={content}
          onClose={hide}
          open={open}/>

      case (theme) {
        Maybe::Just actualTheme =>
          <Ui.Theme theme={actualTheme}>
            <{ modal }>
          </Ui.Theme>

        Maybe::Nothing => modal
      }
    }
  }
}
