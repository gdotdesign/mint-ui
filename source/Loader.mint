component Ui.Loader {
  property children : Array(Html) = []
  property shown : Bool = false

  style base {
    position: relative;
  }

  style loader {
    position: absolute;
    bottom: 0;
    right: 0;
    left: 0;
    top: 0;

    background: rgba(255,255,255,0.8);
    transition-delay: 320ms;
    transition: 320ms;

    pointer-events: {pointerEvents};
    opacity: {opacity};

    justify-content: center;
    align-items: center;
    display: flex;
  }

  get pointerEvents : String {
    if (shown) {
      ""
    } else {
      "none"
    }
  }

  get opacity : Number {
    if (shown) {
      1
    } else {
      0
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>

      <div::loader>
        "Loading..."
      </div>
    </div>
  }
}
