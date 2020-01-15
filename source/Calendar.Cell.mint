component Ui.Calendar.Cell {
  property onClick : Function(Time, Promise(Never, Void)) = (day : Time) : Promise(Never, Void) { Promise.never() }
  property day : Time = Time.now()
  property selected : Bool = false
  property active : Bool = false

  style base {
    border-radius: 6px;
    justify-content: center;
    line-height: 34px;
    cursor: pointer;
    display: flex;
    height: 34px;
    width: 34px;

    background: red;
    color: yellow;
    opacity: #{opacity};

    &:hover {
      background: cyan;
      color: white;
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
