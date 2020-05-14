/* Represents a subscription for `Provider.Pointer` */
record Provider.Pointer.Subscription {
  downs : Function(Html.Event, Promise(Never, Void)),
  moves : Function(Html.Event, Promise(Never, Void)),
  ups : Function(Html.Event, Promise(Never, Void))
}

/* A provider for global Pointer events. */
provider Provider.Pointer : Provider.Pointer.Subscription {
  /* Calls the `moves` function on the subscribers with the given event. */
  fun moves (event : Html.Event) : Array(a) {
    subscriptions
    |> Array.map(
      (subcription : Provider.Pointer.Subscription) : Function(Html.Event, a) { subcription.moves })
    |> Array.map(
      (func : Function(Html.Event, a)) : a { func(event) })
  }

  /* Calls the `downs` function on the subscribers with the given event. */
  fun downs (event : Html.Event) : Array(a) {
    subscriptions
    |> Array.map(
      (subcription : Provider.Pointer.Subscription) : Function(Html.Event, a) { subcription.downs })
    |> Array.map(
      (func : Function(Html.Event, a)) : a { func(event) })
  }

  /* Calls the `ups` function on the subscribers with the given event. */
  fun ups (event : Html.Event) : Array(a) {
    subscriptions
    |> Array.map(
      (subcription : Provider.Pointer.Subscription) : Function(Html.Event, a) { subcription.ups })
    |> Array.map(
      (func : Function(Html.Event, a)) : a { func(event) })
  }

  /* Attaches the provider. */
  fun attach : Void {
    `
    (() => {
      const downs = this._downs || (this._downs = ((event) => #{downs}(_normalizeEvent(event))))
      const moves = this._moves || (this._moves = ((event) => #{moves}(_normalizeEvent(event))))
      const ups = this._ups || (this._ups = ((event) => #{ups}(_normalizeEvent(event))))

      window.addEventListener("pointerdown", downs)
      window.addEventListener("pointermove", moves)
      window.addEventListener("pointerup", ups)
    })()
    `
  }

  /* Detaches the provider. */
  fun detach : Void {
    `
    (() => {
      window.removeEventListener("pointerdown", this._downs)
      window.removeEventListener("pointermove", this._moves)
      window.removeEventListener("pointerup", this._ups)
    })()
    `
  }
}
