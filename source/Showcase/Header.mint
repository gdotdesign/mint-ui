component Ui.Showcase.Header {
  connect Ui exposing { theme }

  property children : Array(Html) = []

  style base {
    border-bottom: 1px solid rgba(0,0,0,0.1);
    font-family: {theme.fontFamily};
    text-transform: uppercase;
    padding-bottom: 10px;
    background: #FDFDFD;
    font-weight: bold;
    font-size: 14px;
    color: #666;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
