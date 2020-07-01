/* This is a cell of the calender component. */
component Ui.Calendar.Cell {
  connect Ui exposing { resolveTheme }

  /* The click event. */
  property onClick : Function(Time, Promise(Never, Void)) = Promise.Extra.never1

  /* The theme for the button. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The day. */
  property day : Time = Time.now()

  /* Wether or not the cell is selected. */
  property selected : Bool = false

  /* Wether or not the cell is active. */
  property active : Bool = false

  style base {
    border-radius: #{17 * actualTheme.borderRadiusCoefficient}px;
    justify-content: center;
    line-height: 34px;
    display: flex;
    height: 34px;
    width: 34px;

    if (active) {
      cursor: pointer;
      opacity: 1;
    } else {
      pointer-events: none;
      opacity: 0.2;
    }

    &:hover {
      if (active) {
        background: #{actualTheme.primary.s500.color};
        color: #{actualTheme.primary.s500.text};
      } else {
        background: #{actualTheme.surface.color};
        color: #{actualTheme.surface.text};
      }
    }

    if (selected) {
      background: #{actualTheme.primary.s500.color};
      color: #{actualTheme.primary.s500.text};
    }
  }

  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  fun handleClick (event : Html.Event) : Promise(Never, Void) {
    onClick(day)
  }

  fun render : Html {
    <div::base
      title={Time.format("yyyy-MM-dd HH:mm:ss", day)}
      onClick={handleClick}>

      <{ Number.toString(Time.day(day)) }>

    </div>
  }
}
