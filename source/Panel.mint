/* A component to display information on the background. */
component Ui.Panel {
  connect Ui exposing { borderRadiusCoefficient }

  property children : Array(Html) = []

  style base {
    border-radius: #{24 * borderRadiusCoefficient}px;
    background: white;
    padding: 32px;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
