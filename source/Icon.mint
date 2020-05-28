component Ui.Icon {
  connect Ui.Icons exposing { icons }

  property autoSize : Bool = false
  property opacity : Number = 1
  property name : String = ""
  property size : Number = 16
  property href : String = ""

  style base {
    opacity: #{opacity};
    fill: currentColor;

    if (autoSize) {
      height: 1em;
      width: 1em;
    } else {
      height: #{size}px;
      width: #{size}px;
    }
  }

  style link {
    color: inherit;
  }

  fun render : Html {
    try {
      {width, height, content} =
        Map.getWithDefault(name, {0, 0, <></>}, icons)

      svg =
        <svg::base
          viewBox="0 0 #{width} #{height}"
          aria-hidden="true">

          <{ content }>

        </svg>

      if (String.Extra.isNotEmpty(href)) {
        <a::link href={href}>
          <svg::base
            viewBox="0 0 #{width} #{height}"
            aria-hidden="true">

            <{ content }>

          </svg>
        </a>
      } else {
        svg
      }
    }
  }
}
