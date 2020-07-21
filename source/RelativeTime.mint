/*
A component to render a time relative from the current time in human
language.
*/
component Ui.RelativeTime {
  /* The date. */
  property date : Time = Time.now()

  /* The current time. */
  state now : Time = Time.now()

  use Provider.Tick { ticks = () { next { now = Time.now() } } }

  /* Styles for the component. */
  style base {
    display: inline-block;
  }

  fun render : Html {
    <time::base title={Time.toIso(date)}>
      <{ Time.relative(date, now) }>
    </time>
  }
}
