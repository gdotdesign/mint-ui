component Ui.Image {
  property draggable : Bool = true
  property height : Number = 26
  property width : Number = 26
  property src : String = ""

  state errored : Bool = false
  state loaded : Bool = false

  style image {
    object-position: center;
    object-fit: cover;

    border-radius: #{width / 7}px;
    height: #{height}px;
    width: #{width}px;

    transition: opacity 120ms;

    if (loaded) {
      opacity: 1;
    } else {
      opacity: 0;
    }
  }

  style base {
    height: #{height}px;
    width: #{width}px;

    border-radius: #{width / 7}px;
    background: #DDD;
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
