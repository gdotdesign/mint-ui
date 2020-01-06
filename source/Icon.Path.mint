component Ui.Icon.Path {
  connect Ui exposing { theme }

  property onClick : Function(Html.Event, Promise(Never, Void)) = (event : Html.Event) : Promise(Never, Void) { Promise.never() }
  property clickable : Bool = true
  property viewbox : String = ""
  property height : String = ""
  property width : String = ""
  property path : String = ""

  style svg {
    pointer-events: #{pointerEvents};
    fill: currentColor;

    &:hover {
      fill: #{theme.hover.color};
      cursor: #{cursor};
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

  fun handleClick (event : Html.Event) : Promise(Never, Void) {
    if (clickable) {
      onClick(event)
    } else {
      next {  }
    }
  }

  fun render : Html {
    <svg::svg
      onClick={handleClick}
      viewBox={viewbox}
      height={height}
      width={width}>

      <path d={path}/>

    </svg>
  }
}
