/* An image component. */
component Ui.Image {
  /* The value for the border-radius CSS property. */
  property borderRadius : String = ""

  /* Wether or not the image fills the width of it's parent element. */
  property fullWidth : Bool = false

  /* Wehter or not the image is draggable using browser drag & drop. */
  property draggable : Bool = false

  /* The height of the image. */
  property height : Number = 100

  /* The width of the image. */
  property width : Number = 100

  /* The source of the image. */
  property src : String = ""

  /* The alt attribute for the image. */
  property alt : String = ""

  /* Wether or not the image is visible. */
  state visible : Bool = false

  /* Wether or not the image is loaded. */
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

  /* The style for the image. */
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

  /* The style for the base. */
  style base {
    background: var(--content-faded-color);
    height: #{height}px;

    if (fullWidth) {
      width: 100%;
    } else {
      width: #{width}px;
    }

    if (String.isBlank(borderRadius)) {
      border-radius: calc(24px * var(--border-radius-coefficient));
    } else {
      border-radius: #{borderRadius};
    }
  }

  /* The load event handler. */
  fun handleLoad : Promise(Never, Void) {
    next { loaded = true }
  }

  /* The drag start event handler. */
  fun handleDragStart (event : Html.Event) : Void {
    if (draggable) {
      void
    } else {
      Html.Event.preventDefault(event)
    }
  }

  /* Renders the image. */
  fun render : Html {
    <div::base as base>
      if (visible) {
        <img::image
          onDragStart={handleDragStart}
          onLoad={handleLoad}
          alt={alt}
          src={src}/>
      }
    </div>
  }
}
