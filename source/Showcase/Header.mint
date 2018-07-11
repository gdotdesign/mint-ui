component Ui.Showcase.Header {
  connect Ui exposing { theme }

  property children : Array(Html) = []

  style base {
    border-bottom: 1px solid rgba(0,0,0,0.1);
    font-family: {theme.fontFamily};
    text-transform: uppercase;
    background: #FDFDFD;
    padding: 5px 15px;
    font-weight: bold;
    font-size: 14px;
    color: #707070;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
