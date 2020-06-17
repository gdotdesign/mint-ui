component Ui.Calendar {
  connect Ui exposing { resolveTheme }

  property onMonthChange : Function(Time, Promise(Never, Void)) = Promise.Extra.never1
  property onChange : Function(Time, Promise(Never, Void)) = Promise.Extra.never1

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property changeMonthOnSelect : Bool = false
  property month : Time = Time.today()
  property date : Time = Time.today()
  property disabled : Bool = false

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    -moz-user-select: none;
    user-select: none;

    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    border-radius: #{24 * actualTheme.borderRadiusCoefficient}px;
    border: 2px solid #{actualTheme.border};
    font-family: #{actualTheme.fontFamily};

    padding: 20px;
    width: 300px;
  }

  style table {
    grid-template-columns: repeat(7, 1fr);
    grid-gap: 5px;
    display: grid;
    width: 100%;
  }

  style header {
    align-items: center;
    display: flex;
    height: 26px;
  }

  style text {
    text-align: center;
    font-weight: bold;
    flex: 1;
  }

  style dayName {
    text-transform: uppercase;
    text-align: center;
    font-weight: bold;
    font-size: 12px;
    opacity: 0.5;
    width: 34px;
  }

  style dayNames {
    border-bottom: 1px solid #{actualTheme.border};
    border-top: 1px solid #{actualTheme.border};
    justify-content: space-between;
    padding: 10px 0;
    margin: 15px 0;
    display: flex;
  }

  fun days : Array(Time) {
    Time.range(startDate, endDate)
  } where {
    startDate =
      month
      |> Time.startOf("month")
      |> Time.startOf("week")

    endDate =
      month
      |> Time.endOf("month")
      |> Time.endOf("week")
  }

  fun onCellClick (day : Time) : Promise(Never, Void) {
    if (Time.month(day) != Time.month(month) && changeMonthOnSelect) {
      sequence {
        onMonthChange(day)
        onChange(day)
      }
    } else {
      onChange(day)
    }
  }

  fun cells : Array(Html) {
    for (day of days()) {
      <Ui.Calendar.Cell
        active={Array.any((item : Time) : Bool { day == item }, range)}
        selected={date == day}
        onClick={onCellClick}
        day={day}/>
    }
  } where {
    range =
      Time.endOf("month", month)
      |> Time.range(Time.startOf("month", month))
  }

  fun dayName (day : Time) : Html {
    <div::dayName>
      <{ Time.format("eee", day) }>
    </div>
  }

  fun dayNames : Array(Html) {
    Time.endOf("week", date)
    |> Time.range(Time.startOf("week", date))
    |> Array.map(dayName)
  }

  fun previousMonth (event : Html.Event) : Promise(Never, Void) {
    onMonthChange(Time.previousMonth(month))
  }

  fun nextMonth (event : Html.Event) : Promise(Never, Void) {
    onMonthChange(Time.nextMonth(month))
  }

  get nextMonthIcon : Html {
    <Ui.Icon
      onClick={nextMonth}
      interactive={true}
      name="chevron-right"/>
  }

  get previousMonthIcon : Html {
    <Ui.Icon
      onClick={previousMonth}
      interactive={true}
      name="chevron-left"/>
  }

  fun render : Html {
    <div::base>
      <div::header>
        <{ previousMonthIcon }>

        <div::text>
          <{ Time.format("MMMM - yyyy", month) }>
        </div>

        <{ nextMonthIcon }>
      </div>

      <div::dayNames>
        <{ dayNames() }>
      </div>

      <div::table>
        <{ cells() }>
      </div>
    </div>
  }
}
