component Ui.Header {
  connect Ui exposing { primaryBackground, primaryText }

  property children : Array(Html) = []

  style base {
    background: #{primaryBackground};
    color: #{primaryText};

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
