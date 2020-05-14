module IntersectionObserver {
  fun new (
    rootMargin : String,
    treshold : Number,
    callback : Function(Number, a)
  ) : IntersectionObserver {
    `
    (() => {
      return new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
          #{callback(`entry.intersectionRatio`)}
        })
      }, {
        rootMargin: #{rootMargin},
        treshold: #{treshold}
      });
    })()
    `
  }

  fun observe (
    element : Dom.Element,
    observer : IntersectionObserver
  ) : IntersectionObserver {
    `#{observer}.observe(#{element}) || #{observer}`
  }

  fun unobserve (
    element : Dom.Element,
    observer : IntersectionObserver
  ) : IntersectionObserver {
    `#{observer}.unobserve(#{element}) || #{observer}`
  }
}
