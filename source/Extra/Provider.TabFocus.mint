record Provider.TabFocus.Subscription {
  onTabIn : Function(Dom.Element, Promise(Never, Void)),
  onTabOut : Function(Dom.Element, Promise(Never, Void))
}

provider Providers.TabFocus : Provider.TabFocus.Subscription {
  fun handleKeyUp (event : Html.Event) : Promise(Never, Void) {
    `
    (() => {
      if (#{event.keyCode} == 9) {
        for (let subscription of this.subscriptions) {
          subscription[1].onTabIn(document.activeElement)
        }
      }
    })()
    `
  }

  fun handleKeyDown (event : Html.Event) : Promise(Never, Void) {
    `
    (() => {
      if (#{event.keyCode} == 9) {
        for (let subscription of this.subscriptions) {
          subscription[1].onTabOut(#{event.target})
        }
      }
    })()
    `
  }

  fun update : Void {
    `
    (() => {
      if (#{subscriptions}.length) {
        this.keyDown || (this.keyDown = ((event) => #{handleKeyDown}(_normalizeEvent(event))))
        this.keyUp || (this.keyUp = ((event) => #{handleKeyUp}(_normalizeEvent(event))))

        window.addEventListener("keydown", this.keyDown, true)
        window.addEventListener("keyup", this.keyUp, true)
      } else {
        window.removeEventListener("keydown", this.keyDown, true)
        window.removeEventListener("keyup", this.keyUp, true)
      }
    })()
    `
  }
}
