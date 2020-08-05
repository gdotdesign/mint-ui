/* A simple checkbox component. */
component Ui.Checkbox {
  /* The handler for the change event. */
  property onChange : Function(Bool, Promise(Never, Void)) = Promise.never1

  /* Wether or not the checkbox is disabled. */
  property disabled : Bool = false

  /* Wether or not the checkbox is checked. */
  property checked : Bool = false

  /* The size of the checkbox. */
  property size : Number = 16

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    justify-content: center;
    display: inline-flex;
    align-items: center;

    position: relative;
    cursor: pointer;
    outline: none;
    padding: 0;
    border: 0;

    font-size: #{size}px;

    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    border: 0.125em solid var(--border);
    height: 2.125em;
    width: 2.125em;

    if (checked) {
      background-color: var(--primary-s500-color);
      border-color: var(--primary-s500-color);
      color: var(--primary-s500-text);
    } else {
      background-color: var(--content-color);
      border-color: var(--border);
      color: var(--content-text);
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      box-shadow: 0 0 0 0.1875em var(--primary-shadow);
      border-color: var(--primary-s500-color);
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
    }
  }

  /* Toggles the checkbox. */
  fun toggle : Promise(Never, Void) {
    onChange(!checked)
  }

  /* Focuses the checkbox. */
  fun focus : Promise(Never, Void) {
    Dom.focus(checkbox)
  }

  /* Renders the checkbox. */
  fun render : Html {
    <button::base as checkbox
      aria-checked={Bool.toString(checked)}
      disabled={disabled}
      onClick={toggle}
      role="checkbox">

      <Ui.Icon
        icon={Ui.Icons:CHECK}
        size={size}
        opacity={
          if (checked) {
            1
          } else {
            0.25
          }
        }/>

    </button>
  }
}
