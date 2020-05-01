component Ui.Content {
  connect Ui exposing { fontFamily, surfaceBackground, surfaceText, primaryBackground }

  property children : Array(Html) = []

  style base {
    font-family: #{fontFamily};

    > *:first-child {
      margin-top: 0;
    }

    > *:last-child {
      margin-bottom: 0;
    }

    h2 {
      margin-top: 2em;
    }

    li + li {
      margin-top: 0.5em;
    }

    a:not([name]):not([class]) {
      color: #{primaryBackground};
    }

    code {
      background: #{surfaceBackground};
      color: #{surfaceText};
      border-radius: 2px;
      display: inline-block;
      padding: 5px 8px;
      font-size: 16px;
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
