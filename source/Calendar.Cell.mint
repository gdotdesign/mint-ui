/* This is a cell of the calendar component. */
component Ui.Calendar.Cell {
  /* The click event. */
  property onClick : Function(Time, Promise(Never, Void)) = Promise.never1

  /* Wether or not the cell is selected. */
  property selected : Bool = false

  /* Wether or not the cell is active (selectable). */
  property active : Bool = false

  /* The size of the component. */
  property size : Number = 16

  /* Wether or not the component is disabled. */
  property disabled : Bool = false

  /* The day. */
  property day : Time

  /* Styles for the cell. */
  style base {
    border-radius: calc(0.78125em * var(--border-radius-coefficient));
    font-size: #{size}px;

    justify-content: center;
    align-items: center;
    display: flex;

    height: 2em;
    width: 2em;

    if (active) {
      cursor: pointer;
      opacity: 1;
    } else {
      pointer-events: none;
      opacity: 0.2;
    }

    if (disabled) {
      pointer-events: none;
    }

    &:hover {
      background: var(--primary-s500-color);
      color: var(--primary-s500-text);
    }

    if (selected) {
      background: var(--primary-s500-color);
      color: var(--primary-s500-text);
    }
  }

  /* The click event handler. */
  fun handleClick (event : Html.Event) : Promise(Never, Void) {
    onClick(day)
  }

  /* Renders the component. */
  fun render : Html {
    <div::base
      title={Time.format("yyyy-MM-dd", day)}
      onClick={handleClick}>

      <{ Time.format("dd", day) }>

    </div>
  }
}
