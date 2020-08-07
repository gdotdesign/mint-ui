/* A toggle component. */
component Ui.Toggle {
  /* The change event handler. */
  property onChange : Function(Bool, Promise(Never, Void)) = Promise.never1

  /* The label for the false position. */
  property offLabel : String = "OFF"

  /* The label for the true position. */
  property onLabel : String = "ON"

  /* Wether or not the toggle is disabled. */
  property disabled : Bool = false

  /* Wether or not the toggle is checked. */
  property checked : Bool = false

  /* The size of the component. */
  property size : Number = 16

  /* The font family to measure the width of the toggle. */
  property fontFamily : String = "Arial"

  /* Styles for the base element. */
  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    if (checked) {
      background-color: var(--primary-s500-color);
      border-color: var(--primary-s500-color);
      color: var(--primary-s500-text);
    } else {
      background-color: var(--content-color);
      border-color: var(--border);
      color: var(--content-text);
    }

    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    border: 0.125em solid;

    display: inline-flex;
    align-items: center;

    font-family: var(--font-family);
    font-size: #{size}px;
    font-weight: bold;

    width: #{width}px;
    height: 2.375em;

    position: relative;
    cursor: pointer;
    outline: none;
    padding: 0;

    transition: background-color 120ms;

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      box-shadow: 0 0 0 0.1875em var(--primary-shadow);
      border-color: var(--primary-s500-color);
    }

    &:disabled {
      filter: saturate(0) brightness(0.8);
      cursor: not-allowed;
    }
  }

  /* Style for the label. */
  style label (shown : Bool) {
    transition: opacity 120ms;
    text-align: center;
    font-size: 0.875em;
    width: 50%;

    if (shown) {
      opacity: 1;
    } else {
      opacity: 0;
    }
  }

  /* Styles for the overlay. */
  style overlay {
    border-radius: calc(#{size}px * var(--border-radius-coefficient));
    background: var(--surface-s500-color);
    width: calc(50% - 0.375em);
    position: absolute;
    bottom: 0.1875em;
    top: 0.1875em;

    transition: left 120ms;

    if (checked) {
      left: calc(100% / 2 + 0.1875em);
    } else {
      left: 0.1875em;
    }
  }

  /* Returns the width of the toggle by measuring the labels. */
  get width : Number {
    try {
      font =
        "#{size * 0.875}px #{fontFamily}"

      onWidth =
        onLabel
        |> Dom.measureText(font)
        |> Math.ceil()

      offWidth =
        offLabel
        |> Dom.measureText(font)
        |> Math.ceil()

      Math.max(offWidth, onWidth) * 2 + size * 3
    }
  }

  /* Toggles the componnet. */
  fun toggle : Promise(Never, Void) {
    onChange(!checked)
  }

  /* Renders the component. */
  fun render : Html {
    <button::base
      aria-checked={Bool.toString(checked)}
      disabled={disabled}
      onClick={toggle}
      role="checkbox">

      <div::label(checked) aria-hidden="true">
        <{ onLabel }>
      </div>

      <div::label(!checked) aria-hidden="true">
        <{ offLabel }>
      </div>

      <div::overlay aria-hidden="true"/>

    </button>
  }
}
