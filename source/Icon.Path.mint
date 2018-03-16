component Ui.Icon.Path {
  connect Ui exposing { theme }

  property onClick : Function(Html.Event, Void) = \event : Html.Event => void
  property clickable : Bool = true
  property viewbox : String = ""
  property height : String = ""
  property width : String = ""
  property path : String = ""

  style svg {
    pointer-events: {pointerEvents};
    fill: currentColor;

    &:hover {
      fill: {theme.hover.color};
      cursor: {cursor};
    }
  }

  get pointerEvents : String {
    if (clickable) {
      ""
    } else {
      "none"
    }
  }

  get cursor : String {
    if (clickable) {
      "pointer"
    } else {
      ""
    }
  }

  get handler : Function(Html.Event, Void) {
    if (clickable) {
      onClick
    } else {
      \event : Html.Event => void
    }
  }

  fun render : Html {
    <svg::svg
      onClick={handler}
      viewBox={viewbox}
      height={height}
      width={width}>

      <path d={path}/>

    </svg>
  }
}
