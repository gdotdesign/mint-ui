component Ui.Card {
  property children : Array(Html) = []

  style base {
    border: 1px solid #e4e4e4;
    flex-direction: column;
    border-radius: 4px;
    display: flex;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

component Ui.Card.Image {
  property src : String = ""

  style base {
    display: block;
    width: 100%;
    border: 0;

    &:first-child {
      border-top-right-radius: 4px;
      border-top-left-radius: 4px;
      width: calc(100% + 2px);
      margin-left: -1px;
      margin-top: -1px;
    }
  }

  fun render : Html {
    <img::base src={src}/>
  }
}

component Ui.Card.Block {
  property children : Array(Html) = []

  style base {
    padding: 1.25em;
    flex: 1;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

component Ui.Card.Title {
  property children : Array(Html) = []

  style base {
    margin-bottom: 0.75em;
    font-size: 1.25em;
    font-weight: bold;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

component Ui.Card.Text {
  property children : Array(Html) = []

  style base {
    line-height: 1.5;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
