module Promise.Extra {
  fun create : Tuple(Function(value, Void), Function(error, Void), Promise(error, value)) {
    `
    (() => {
      let resolve, reject;

      const promise = new Promise((a, b) => {
        resolve = a
        reject = b
      })

      return [
        (value) => resolve(value),
        (error) => reject(error),
        promise
      ]
    })()`
  }

  fun never1 (param : a) : Promise(Never, Void) {
    Promise.resolve(void)
  }

  fun never2 (param : a) : Promise(Never, Void) {
    Promise.resolve(void)
  }
}

module Window.Extra {
  fun isActiveURL (url : String) : Bool {
    Window.url() == Url.parse(url)
  }

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
  fun containsMaybe (
    maybeElement : Maybe(Dom.Element),
    base : Dom.Element
  ) : Bool {
    maybeElement
    |> Maybe.map(Dom.contains(base))
    |> Maybe.withDefault(false)
  }

  fun smoothScrollTo (element : Dom.Element, left : Number, top : Number) : Promise(Never, Void) {
    `#{element}.scrollTo({
      behavior: 'smooth',
      left: #{left},
      top: #{top} })`
  }

  fun scrollTo (element : Dom.Element, left : Number, top : Number) : Promise(Never, Void) {
    `#{element}.scrollTo({
      left: #{left},
      top: #{top} })`
  }

  fun getClientWidth (element : Dom.Element) : Number {
    `#{element}.clientWidth || 0`
  }

  fun getClientHeight (element : Dom.Element) : Number {
    `#{element}.clientHeight || 0`
  }

  fun getScrollLeft (element : Dom.Element) : Number {
    `#{element}.scrollLeft || 0`
  }

  fun getScrollWidth (element : Dom.Element) : Number {
    `#{element}.scrollWidth || 0`
  }

  fun getScrollTop (element : Dom.Element) : Number {
    `#{element}.scrollTop || 0`
  }

  fun getScrollHeight (element : Dom.Element) : Number {
    `#{element}.scrollHeight || 0`
  }

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

  fun setAttribute (
    attribute : String,
    value : String,
    element : Dom.Element
  ) : Dom.Element {
    `#{element}.setAttribute(#{attribute}, #{value}) && element`
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

  fun getChildren (element : Dom.Element) : Array(Dom.Element) {
    `Array.from(#{element}.children)`
  }

  fun getTagName (element : Dom.Element) : String {
    `#{element}.tagName`
  }

  fun getActiveElement : Maybe(Dom.Element) {
    `
    (() => {
      if (document.activeElement) {
        return #{Maybe::Just(`document.activeElement`)}
      } else {
        return #{Maybe::Nothing}
      }
    })()
    `
  }

  fun blurActiveElement : Promise(Never, Void) {
    `document.activeElement && document.activeElement.blur()`
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

module Html.Extra {
  fun isNotEmpty (element : Html) {
    `!!#{element}`
  }
}

module Array.Extra {
  fun findByAndMap (
    method : Function(a, Tuple(Bool, b)),
    array : Array(a)
  ) : Maybe(b) {
    `
    (() => {
      for (let item of #{array}) {
        const [found, value]   = #{method}(item)

        if (found) {
          return #{Maybe::Just(`value`)}
        }
      }

      return #{Maybe::Nothing}
    })()
    `
  }

  fun reverseIf (condition : Bool, array : Array(a)) : Array(a) {
    if (condition) {
      Array.reverse(array)
    } else {
      array
    }
  }
}
