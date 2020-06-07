component Ui.Icon {
  connect Ui exposing { primaryBackground }
  connect Ui.Icons exposing { icons }

  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property interactive : Bool = false
  property disabled : Bool = false
  property autoSize : Bool = false
  property opacity : Number = 1
  property name : String = ""
  property size : Number = 16
  property href : String = ""

  style base {
    opacity: #{opacity};
    fill: currentColor;

    if (interactive) {
      pointer-events: auto;
      cursor: pointer;
    } else {
      pointer-events: none;
      cursor: auto;
    }

    if (disabled) {
      pointer-events: none;
      opacity: 0.5;
    }

    &:hover {
      color: #{primaryBackground};
    }

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
          onClick={onClick}>

          <{ content }>

        </svg>

      if (String.Extra.isNotEmpty(href)) {
        <a::link href={href}>
          <{ svg }>
        </a>
      } else {
        svg
      }
    }
  }
}
