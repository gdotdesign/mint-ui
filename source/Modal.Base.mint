component Ui.Modal.Base {
  property onClose : Function(Promise(Never, Void)) = Promise.never
  property closeOnOutsideClick : Bool = true
  property transitionDuration : Number = 240
  property content : Html = <></>
  property zIndex : Number = 100
  property open : Bool = false

  /* Styles for the base element. */
  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    background: rgba(0, 0, 0, 0.8);
    max-height: 100vh;
    overflow-y: auto;
    display: flex;

    transform: translate3d(0,0,0);
    z-index: #{zIndex};
    position: fixed;
    bottom: 0;
    right: 0;
    left: 0;
    top: 0;

    if (open) {
      transition: opacity #{transitionDuration}ms 0ms ease,
                  visibility 1ms 0ms ease;

      pointer-events: auto;
      visibility: visible;
      opacity: 1;
    } else {
      transition: opacity #{transitionDuration}ms 0ms ease,
                  visibility 1ms #{transitionDuration}ms ease;

      pointer-events: none;
      visibility: hidden;
      opacity: 0;
    }
  }

  /* Styles for the wrapper. */
  style wrapper {
    transition: transform #{transitionDuration}ms ease;
    padding: 1em;
    margin: auto;

    if (open) {
      transform: translateY(0);
    } else {
      transform: translateY(-3em);
    }
  }

  /* Handles the click event on the backdrop. */
  fun handleClick (event : Html.Event) : Promise(Never, Void) {
    if (Maybe::Just(event.target) == base && closeOnOutsideClick) {
      onClose()
    } else {
      next {  }
    }
  }

  fun render : Html {
    <div::base as base onClick={handleClick}>
      <div::wrapper>
        <{ content }>
      </div>
    </div>
  }
}
