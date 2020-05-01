module Promise.Extra {
  fun never1 (param : a) : Promise(Never, Void) {
    Promise.resolve(void)
  }

  fun never2 (param : a) : Promise(Never, Void) {
    Promise.resolve(void)
  }
}

module Window.Extra {
  fun alert (message : String) : Promise(Never, Void) {
    `window.alert(#{message})`
  }

  fun refreshHash : Promise(Never, Void) {
    `requestAnimationFrame(() => {
      if (window.location.hash) {
        window.location.href = window.location.hash
      }
    })
    `
  }
}

module String.Extra {
  fun isNotEmpty (string : String) : Bool {
    !String.isEmpty(String.trim(string))
  }

  fun dropLeft (number : Number, string : String) : String {
    `#{string}.slice(#{Math.clamp(0, number, String.size(string))})`
  }

  fun parameterize (string : String) : String {
    `
    #{string}
    .replace(/[^a-z0-9\-_]+/ig, '-')
    .replace(/-{2,}/g, '-')
    .replace(/^-|-$/i, '')
    `
  }
}

module Dom.Extra {
  fun measureText (font : String, text : String) : Number {
    `
    (() => {
      if (!this.canvas) { this.canvas = document.createElement('canvas') }
      const ctx = this.canvas.getContext("2d");
      ctx.font = #{font};
      return ctx.measureText(#{text}).width
    })()
    `
  }

  fun tableOfContents (selector : String, element : Dom.Element) : Array(Tuple(String, String, String)) {
    element
    |> Dom.Extra.getElementsBySelector(selector)
    |> Array.map(
      (item : Dom.Element) : Tuple(String, String, String) {
        try {
          tag =
            item
            |> Dom.Extra.getTagName()
            |> String.toLowerCase()

          text =
            Dom.Extra.getTextContent(item)

          hash =
            String.Extra.parameterize(text)

          {tag, text, hash}
        }
      })
  }

  fun getElementsBySelector (selector : String, element : Dom.Element) : Array(Dom.Element) {
    `Array.from(#{element}.querySelectorAll(#{selector}))`
  }

  fun getAttribute (attribute : String, element : Dom.Element) : String {
    `#{element}.getAttribute(#{attribute}) || ""`
  }

  fun getTextContent (element : Dom.Element) : String {
    `#{element}.textContent`
  }

  fun getTagName (element : Dom.Element) : String {
    `#{element}.tagName`
  }
}

module Test.Extra {
  fun spyOn (entity : a) : a {
    `
    (() => {
      if (typeof #{entity} == "function") {
        let _;

        _ = function(...args){
          _._called = true
          return #{entity}(...args)
        }

        return _
      } else {
        return #{entity}
      }
    })()
    `
  }

  fun assertFunctionCalled (entity : a, context : Test.Context(c)) : Test.Context(c) {
    `
    #{context}.step((item) => {
      if (#{entity}._called) {
        return item
      } else {
        throw "The given function was not called!"
      }
    })
    `
  }

  fun assertFunctionNotCalled (entity : a, context : Test.Context(c)) : Test.Context(c) {
    `
    #{context}.step((item) => {
      if (#{entity}._called) {
        throw "The given function was called!"
      } else {
        return item
      }
    })
    `
  }
}
