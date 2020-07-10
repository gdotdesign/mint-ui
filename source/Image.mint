component Ui.Image {
  connect Ui exposing { resolveTheme }

  /* The theme for the image. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  property borderRadius : String = ""
  property fullWidth : Bool = false
  property draggable : Bool = false
  property height : Number = 100
  property width : Number = 100
  property src : String = ""
  property alt : String = ""

  state visible : Bool = false
  state loaded : Bool = false

  use Provider.Intersection {
    rootMargin = "50px",
    treshold = 0.01,
    element = base,
    callback =
      (ratio : Number) {
        if (ratio > 0) {
          next { visible = true }
        } else {
          next {  }
        }
      }
  } when {
    !visible
  }

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
    background: #{actualTheme.surface.color};
    height: #{height}px;

    if (fullWidth) {
      width: 100%;
    } else {
      width: #{width}px;
    }

    if (String.isEmpty(borderRadius)) {
      border-radius: #{24 * actualTheme.borderRadiusCoefficient}px;
    } else {
      border-radius: #{borderRadius};
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
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
    <div::base as base>
      if (visible) {
        <img::image
          onDragStart={handleDragStart}
          onLoad={setLoaded}
          alt={alt}
          src={src}/>
      }
    </div>
  }
}
