component Ui.Calendar {
  connect Ui exposing {
    fontFamily,
    contentBackground,
    contentText,
    borderRadiusCoefficient,
    surfaceBackground,
    surfaceText
  }

  property onMonthChange : Function(Time, Promise(Never, Void)) = Promise.Extra.never1
  property onChange : Function(Time, Promise(Never, Void)) = Promise.Extra.never1

  property changeMonthOnSelect : Bool = false
  property month : Time = Time.today()
  property date : Time = Time.today()
  property disabled : Bool = false

  style base {
    -moz-user-select: none;
    user-select: none;

    background: #{contentBackground};
    color: #{contentText};

    border: 2px solid #{surfaceBackground};
    border-radius: #{24 * borderRadiusCoefficient}px;
    font-family: #{fontFamily};

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
    border-bottom: 1px solid #{surfaceBackground};
    border-top: 1px solid #{surfaceBackground};
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
    <Ui.Icon.Path
      onClick={nextMonth}
      viewbox="0 0 9 16"
      height="16px"
      width="9px"
      path={
        "M6 8L.1 1.78c-.14-.16-.14-.4.02-.57L1.17.13c.15-.16.4-.1" \
        "6.54 0l7.2 7.6c.07.07.1.18.1.28 0 .1-.03.2-.1.3l-7.2 7.6" \
        "c-.14.14-.38.14-.53-.02l-1.05-1.1c-.16-.15-.16-.4 0-.56L" \
        "5.98 8z"
      }/>
  }

  get previousMonthIcon : Html {
    <Ui.Icon.Path
      onClick={previousMonth}
      viewbox="0 0 9 16"
      height="16px"
      width="9px"
      path={
        "M3 8l5.9-6.22c.14-.16.14-.4-.02-.57L7.83.13c-.15-.16-.4-" \
        ".16-.54 0L.1 7.7c-.07.07-.1.17-.1.28 0 .1.03.2.1.3l7.2 7" \
        ".6c.14.14.38.14.53-.02l1.05-1.1c.16-.15.16-.4 0-.56L3.02" \
        " 8z"
      }/>
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
