component Ui.Carousel {
  property pages : Array(Html) = []

  state startPosition : Number = 0
  state eventPosition : Number = 0
  state dragging : Bool = false

  use Provider.Pointer {
    downs = (event : Html.Event) { next {  } },
    moves = moves,
    ups = ups
  } when {
    dragging
  }

  style base {
    if (dragging) {
      user-select: none;
    }

    white-space: nowrap;
    overflow: auto;
    display: block;

    -ms-overflow-style: none;
    scrollbar-width: none;

    &::-webkit-scrollbar {
      display: none;
    }
  }

  style page {
    scroll-snap-align: start;
    display: inline-block;
    width: 100%;
  }

  fun goTo (index : Number) {
    case (base) {
      Maybe::Just element =>
        try {
          rect =
            Dom.getDimensions(element)

          Dom.Extra.smoothScrollTo(element, rect.width * index, 0)
        }

      Maybe::Nothing => next {  }
    }
  }

  fun nextPage {
    goTo(currentPage + 1)
  }

  fun previousPage {
    goTo(currentPage - 1)
  }

  get children : Array(Dom.Element) {
    case (base) {
      Maybe::Just element => Dom.Extra.getChildren(element)
      Maybe::Nothing => []
    }
  }

  get currentPage : Number {
    case (base) {
      Maybe::Nothing => 0

      Maybe::Just element =>
        try {
          width =
            Dom.getDimensions(element).width

          scrollLeft =
            Dom.Extra.getScrollLeft(element)

          Math.round(scrollLeft / width)
        }
    }
  }

  fun startScroll (event : Html.Event) {
    case (base) {
      Maybe::Nothing => next {  }

      Maybe::Just element =>
        next
          {
            startPosition = Dom.Extra.getScrollLeft(element),
            eventPosition = event.pageX,
            dragging = true
          }
    }
  }

  fun moves (event : Html.Event) {
    case (base) {
      Maybe::Nothing => next {  }

      Maybe::Just element =>
        try {
          position =
            startPosition + (eventPosition - event.pageX)
            |> Math.clamp(0, Dom.Extra.getScrollWidth(element))

          Dom.Extra.scrollTo(element, position, 0)
        }
    }
  }

  fun ups (event : Html.Event) {
    sequence {
      next { dragging = false }
      goTo(currentPage)
    }
  }

  fun render : Html {
    <div::base as base onPointerDown={startScroll}>
      for (item of pages) {
        <div::page>
          <{ item }>
        </div>
      }
    </div>
  }
}
