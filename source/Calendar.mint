/* A simple calendar component where the days can be selected. */
component Ui.Calendar {
  /* The month change event handler. */
  property onMonthChange : Function(Time, Promise(Never, Void)) = Promise.never1

  /* The change event handler. */
  property onChange : Function(Time, Promise(Never, Void)) = Promise.never1

  /* Wether or not to trigger the `onMonthChange` event if clicking on a day in an other month. */
  property changeMonthOnSelect : Bool = false

  /* The month to display. */
  property month : Time = Time.today()

  /* The selected day. */
  property day : Time = Time.today()

  /* Wether or not the calender is embedded (in a picker for example). */
  property embedded : Bool = false

  /* Wether or not the component is disabled. */
  property disabled : Bool = false

  /* The size of the component. */
  property size : Number = 16

  /* Styles for the base. */
  style base {
    -moz-user-select: none;
    user-select: none;

    background: var(--content-color);
    color: var(--content-text);

    font-family: var(--font-family);
    font-size: #{size}px;

    grid-gap: 1em;
    display: grid;

    if (embedded) {
      padding: 0.5em;
    } else {
      border-radius: calc(1.5625em * var(--border-radius-coefficient));
      border: 0.125em solid var(--border);
      padding: 1.25em;
    }

    if (disabled) {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    }
  }

  /* Style for the table. */
  style table {
    grid-template-columns: repeat(7, 1fr);
    grid-gap: 0.3125em;
    display: grid;
    width: 100%;
  }

  /* Style for the header. */
  style header {
    align-items: center;
    line-height: 1;
    display: flex;
  }

  /* Style for the text. */
  style text {
    text-align: center;
    font-weight: bold;
    flex: 1;
  }

  /* Style for the day name. */
  style dayName {
    text-transform: uppercase;
    text-align: center;
    font-weight: bold;
    font-size: 0.74em;
    opacity: 0.5;
    width: 2em;
  }

  /* Style for the day names. */
  style dayNames {
    border-bottom: 0.0625em solid var(--border);
    border-top: 0.0625em solid var(--border);

    justify-content: space-between;
    white-space: nowrap;
    display: flex;

    padding: 0.625em 0;
    line-height: 1;
  }

  /* Event handler for the cell click. */
  fun handleCellClick (day : Time) : Promise(Never, Void) {
    if (Time.month(day) != Time.month(month) && changeMonthOnSelect) {
      sequence {
        onMonthChange(day)
        onChange(day)
      }
    } else {
      onChange(day)
    }
  }

  /* Event handler for the chevron left icon click. */
  fun handleChevronLeftClick (event : Html.Event) : Promise(Never, Void) {
    onMonthChange(Time.previousMonth(month))
  }

  /* Event handler for the chevron right icon click. */
  fun handleChevronRightClick (event : Html.Event) : Promise(Never, Void) {
    onMonthChange(Time.nextMonth(month))
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::header>
        <Ui.Icon
          onClick={handleChevronLeftClick}
          icon={Ui.Icons:CHEVRON_LEFT}
          disabled={disabled}
          interactive={true}
          size={size}/>

        <div::text>
          <{ Time.format("MMMM - yyyy", month) }>
        </div>

        <Ui.Icon
          onClick={handleChevronRightClick}
          icon={Ui.Icons:CHEVRON_RIGHT}
          disabled={disabled}
          interactive={true}
          size={size}/>
      </div>

      <div::dayNames>
        try {
          range =
            Time.range(Time.startOf("week", day), Time.endOf("week", day))

          for (day of range) {
            <div::dayName>
              <{ Time.format("eee", day) }>
            </div>
          }
        }
      </div>

      <div::table>
        try {
          startDate =
            month
            |> Time.startOf("month")
            |> Time.startOf("week")

          endDate =
            month
            |> Time.endOf("month")
            |> Time.endOf("week")

          days =
            Time.range(startDate, endDate)

          range =
            Time.endOf("month", month)
            |> Time.range(Time.startOf("month", month))

          for (cell of days) {
            <Ui.Calendar.Cell
              active={Array.any((item : Time) : Bool { cell == item }, range)}
              onClick={handleCellClick}
              selected={day == cell}
              size={size}
              day={cell}/>
          }
        }
      </div>
    </div>
  }
}
