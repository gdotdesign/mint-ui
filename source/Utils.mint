module Ui.Utils {
  fun disabledHandler (
    disabled : Bool,
    handler : Function(a, Promise(Never, Void))
  ) : Function(a, Promise(Never, Void)) {
    if (disabled) {
      Promise.Extra.never1()
    } else {
      handler
    }
  }
}
