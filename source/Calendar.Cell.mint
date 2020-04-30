component Ui.Calendar.Cell {
  connect Ui exposing {
    surfaceBackground,
    surfaceText,
    primaryBackground,
    primaryText,
    borderRadiusCoefficient
  }

  property onClick : Function(Time, Promise(Never, Void)) = (day : Time) : Promise(Never, Void) { Promise.never() }
  property day : Time = Time.now()
  property selected : Bool = false
  property active : Bool = false

  style base {
    border-radius: #{17 * borderRadiusCoefficient}px;
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
        background: #{primaryBackground};
        color: #{primaryText};
      } else {
        background: #{surfaceBackground};
        color: #{surfaceText};
      }
    }

    if (Debug.log(selected)) {
      background: #{primaryBackground};
      color: #{primaryText};
    }
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
