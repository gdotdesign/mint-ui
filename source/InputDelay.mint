module Ui.InputDelay {
  /* The change event handler. */
  fun handle (timeoutId : Number, delay : Number, event : Html.Event) : Tuple(Number, String, Promise(Never, Void)) {
    try {
      {resolve, reject, promise} =
        Promise.Extra.create()

      value =
        Dom.getValue(event.target)

      `clearTimeout(#{timeoutId})`

      id =
        `setTimeout(#{resolve}, #{delay})`

      {id, value, promise}
    }
  }
}
