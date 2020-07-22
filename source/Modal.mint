/* A generic modal component. */
global component Ui.Modal {
  /* The resolve function. */
  state resolve : Function(Void, Void) = (value : Void) { void }

  /* The reject function. */
  state reject : Function(String, Void) = (error : String) { void }

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
    showWithOptions(content, 100, 240)
  }

  /* Shows the component with the given content and z-index. */
  fun showWithOptions (
    content : Html,
    zIndex : Number,
    transitionDuration : Number
  ) : Promise(String, Void) {
    try {
      {resolve, reject, promise} =
        Promise.Extra.create()

      next
        {
          transitionDuration = transitionDuration,
          content = content,
          resolve = resolve,
          zIndex = zIndex,
          reject = reject,
          open = true
        }

      Dom.Extra.blurActiveElement()
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
    <Ui.Modal.Base
      content={content}
      onClose={hide}
      open={open}/>
  }
}
