component Ui.Content {
  connect Ui exposing { fontFamily, surfaceBackground, surfaceText }

  property children : Array(Html) = []

  style base {
    font-family: #{fontFamily};
    color: #333;

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

    code {
      background: #{surfaceBackground};
      color: #{surfaceText};
      display: inline-block;
      padding: 5px 10px;
      font-size: inherit;
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
