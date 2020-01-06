component Ui.Calendar.Cell {
  connect Ui exposing { theme }

  property onClick : Function(Time, Promise(Never, Void)) = (day : Time) : Promise(Never, Void) { Promise.never() }
  property day : Time = Time.now()
  property selected : Bool = false
  property active : Bool = false

  style base {
    border-radius: #{theme.border.radius};
    justify-content: center;
    line-height: 34px;
    cursor: pointer;
    display: flex;
    height: 34px;
    width: 34px;

    background: #{colors.background};
    color: #{colors.text};
    opacity: #{opacity};

    &:hover {
      background: #{theme.colors.primary.background};
      color: #{theme.colors.primary.text};
    }
  }

  get colors : Ui.Theme.Color {
    if (selected) {
      theme.colors.primary
    } else {
      theme.colors.inputSecondary
    }
  }

  get opacity : String {
    if (active) {
      "1"
    } else {
      "0.25"
    }
  }

  fun render : Html {
    <div::base
      title={Time.format("YYYY-MM-DD HH:mm:ss", day)}
      onClick={(event : Html.Event) : Promise(Never, Void) { onClick(day) }}>

      <{ Number.toString(Time.day(day)) }>

    </div>
  }
}
