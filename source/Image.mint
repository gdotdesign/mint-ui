component Ui.Image {
  connect Ui exposing { surfaceBackground, borderRadiusCoefficient }

  property borderRadius : String = ""
  property fullWidth : Bool = false
  property draggable : Bool = true
  property height : Number = 26
  property width : Number = 26
  property src : String = ""

  state errored : Bool = false
  state loaded : Bool = false

  style image {
    object-position: center;
    object-fit: cover;

    transition: opacity 120ms;
    border-radius: inherit;
    height: inherit;
    width: inherit;

    if (loaded) {
      opacity: 1;
    } else {
      opacity: 0;
    }
  }

  style base {
    background: #{surfaceBackground};
    border-radius: #{width / 7}px;
    height: #{height}px;
    width: #{width}px;

    if (String.isEmpty(borderRadius)) {
      border-radius: #{width / 7}px;
    } else {
      border-radius: #{borderRadius};
    }
  }

  fun setLoaded : Promise(Never, Void) {
    next { loaded = true }
  }

  fun handleDragStart (event : Html.Event) : Void {
    if (draggable) {
      void
    } else {
      Html.Event.preventDefault(event)
    }
  }

  fun render : Html {
    <div::base>
      <img::image
        onDragStart={handleDragStart}
        onLoad={setLoaded}
        src={src}/>
    </div>
  }
}
