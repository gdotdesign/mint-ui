component Ui.Showcase.Example {
  property children : Array(Html) = []

  style base {
    background: linear-gradient(45deg,#EEE 25%, transparent 25%, transparent 75%, #EEE 75%, #EEE),
                linear-gradient(45deg,#EEE 25%,transparent 25%,transparent 75%,#EEE 75%,#EEE);

    background-position: 0 0,10px 10px;
    background-size: 20px 20px;
    justify-content: center;
    border: 1px solid #EEE;
    align-items: center;
    min-height: 400px;
    display: flex;
    flex: 1;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
