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

    if (shown) {
      opacity: 1;
    } else {
      pointer-events: none;
      opacity: 0;
    }

    justify-content: center;
    align-items: center;
    display: flex;
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
