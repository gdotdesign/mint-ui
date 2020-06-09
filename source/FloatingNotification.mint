component Ui.FloatingNotification {
  connect Ui exposing { fontFamily, darkMode, mobile, borderRadiusCoefficient }

  property children : Array(Html) = []

  style base {
    border-radius: #{24 * borderRadiusCoefficient}px;
    position: fixed;
    padding: 20px;
    color: white;
    bottom: 20px;
    z-index: 200;

    font-family: #{fontFamily};
    text-align: center;
    font-weight: bold;

    if (mobile) {
      transform: none;
      padding: 10px;
      left: 4px;
      right: 4px;
      bottom: 4px;
    } else {
      transform: translateX(-50%);
      bottom: 20px;
      left: 50%;
    }

    @supports (not (backdrop-filter: blur(3px))) {
      if (darkMode) {
        background: rgba(75,75,75,0.92);
      } else {
        background: rgba(50,50,50,0.92);
      }
    }

    @supports (backdrop-filter: blur(3px)) {
      backdrop-filter: blur(3px);

      if (darkMode) {
        background: rgba(80,80,80,0.8);
      } else {
        background: rgba(30,30,30,0.8);
      }
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
