record Ui.Time.State {
  now : Time
}

record TickProvider.Data {
  ticks : Function(Void)
}

component Ui.Time {
  property date : Time = Time.now()

  state : Ui.Time.State { now = Time.now() }

  use TickProvider { ticks = \ => next { now = Time.now() } }

  style base {
    display: inline-block;
  }

  fun render : Html {
    <div::base title={Time.toIso(date)}>
      <{ Time.relative(date, state.now) }>
    </div>
  }
}
