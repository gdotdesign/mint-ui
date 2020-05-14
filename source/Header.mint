component Ui.Header {
  connect Ui exposing { surfaceBackground, surfaceText }

  property children : Array(Html) = []

  style base {
    background: #{surfaceBackground};
    color: #{surfaceText};

    padding: 0 32px;
    height: 64px;

    box-sizing: border-box;
    align-items: center;
    display: flex;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
