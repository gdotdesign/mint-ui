/* A select component using the native `select` element. */
component Ui.Native.Select {
  /* The change event handler. */
  property onChange : Function(String, Promise(Never, Void)) = Promise.never1

  /* The items to show. */
  property items : Array(Ui.ListItem) = []

  /* The placeholder to show when there is no value selected. */
  property placeholder : String = ""

  /* The key of the current selected element. */
  property value : String = ""

  /* Wether or not the select is invalid. */
  property invalid : Bool = false

  /* Wether or not the select is disabled. */
  property disabled : Bool = false

  /* The size of the select. */
  property size : Number = 16

  /* A variable for tracking the focused state. */
  state focused : Bool = false

  style element {
    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    border: #{size * 0.125}px solid var(--border);
    background-color: var(--content-color);
    color: var(--content-text);

    font-family: var(--font-family);
    font-size: #{size}px;
    line-height: 1.25em;

    padding: 0.5em 0.625em;
    height: 2.375em;

    box-sizing: border-box;
    position: relative;
    user-select: none;
    outline: none;

    if (disabled) {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    } else {
      cursor: pointer;
    }

    if (invalid && focused) {
      box-shadow: 0 0 0 0.1875em var(--danger-shadow);
      border-color: var(--danger-s300-color);
    } else if (invalid) {
      border-color: var(--danger-s500-color);
    } else if (focused) {
      box-shadow: 0 0 0 0.1875em var(--primary-shadow);
      border-color: var(--primary-s500-color);
    } else {
      border-color: var(--border);
    }
  }

  style placeholder {
    user-select: none;
    opacity: 0.5;
  }

  style select {
    position: absolute;
    cursor: pointer;
    width: 100%;
    z-index: 1;
    opacity: 0;
    bottom: 0;
    right: 0;
    left: 0;
    top: 0;

    if (disabled) {
      pointer-events: none;
    }
  }

  style grid {
    grid-template-columns: 1fr min-content;
    align-items: center;
    grid-gap: 0.625em;
    display: grid;
  }

  /* The change event handler. */
  fun handleChange (event : Html.Event) {
    event.target
    |> Dom.getValue
    |> onChange
  }

  /* The focus event handler. */
  fun handleFocus {
    next { focused = true }
  }

  /* The blur event handler. */
  fun handleBlur {
    next { focused = false }
  }

  /* Renders the select. */
  fun render : Html {
    try {
      label =
        items
        |> Array.find(
          (item : Ui.ListItem) : Bool { Ui.ListItem.key(item) == value })
        |> Maybe.map(
          (item : Ui.ListItem) {
            <div>
              <{ Ui.ListItem.content(item) }>
            </div>
          })
        |> Maybe.withDefault(
          <div::placeholder>
            <{ placeholder }>
          </div>)

      grid =
        <div::grid>
          <{ label }>

          <Ui.Icon
            icon={Ui.Icons:CHEVRON_DOWN}
            autoSize={true}/>
        </div>

      <div::element as element>
        <select::select
          onChange={handleChange}
          onFocus={handleFocus}
          onBlur={handleBlur}
          disabled={disabled}
          value={value}>

          for (item of items) {
            case (item) {
              Ui.ListItem::Divider =>
                <option
                  disabled={true}
                  label="─────────────"/>

              Ui.ListItem::Item content key =>
                <option value={key}>
                  <{ content }>
                </option>
            }
          }

        </select>

        <{ grid }>
      </div>
    }
  }
}
