component Ui.Showcase.Example {
  connect Ui exposing { surfaceBackground }

  property children : Array(Html) = []

  style base {
    background: linear-gradient(45deg,#{surfaceBackground} 25%, transparent 25%, transparent 75%, #{surfaceBackground} 75%, #{surfaceBackground}),
                linear-gradient(45deg,#{surfaceBackground} 25%,transparent 25%,transparent 75%,#{surfaceBackground} 75%,#{surfaceBackground});

    background-position: 0 0,10px 10px;
    background-size: 20px 20px;
    justify-content: center;
    border: 1px solid #{surfaceBackground};
    align-items: center;
    min-height: 400px;
    display: flex;
    overflow: hidden;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
