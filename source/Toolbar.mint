component Ui.Toolbar {
  connect Ui exposing { theme }

  property children : Array(Html) = []
  property background : String = ""
  property color : String = ""

  style base {
    border-bottom: 2px solid rgba(0,0,0,0.1);
    background: #{backgroundColor};
    align-items: center;
    color: #{textColor};
    padding: 0 24px;
    display: flex;
    height: 56px;
  }

  get backgroundColor : String {
    if (String.isEmpty(background)) {
      theme.colors.primary.background
    } else {
      background
    }
  }

  get textColor : String {
    if (String.isEmpty(color)) {
      theme.colors.primary.text
    } else {
      color
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
