component Ui.Toggle {
  connect Ui exposing { fontFamily }

  property onChange : Function(Bool, Promise(Never, Void)) =
    (value : Bool) : Promise(Never, Void) { next {  } }

  property offLabel : String = "OFF"
  property onLabel : String = "ON"
  property disabled : Bool = false
  property checked : Bool = false
  property size : Number = 34

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    if (checked) {
      background-color: #0659fd;
      color: #FFF;
    } else {
      background-color: #E9E9E9;
      color: #666;
    }

    border-radius: #{size * 0.5}px;
    border: 0;

    font-size: #{size * 0.875}px;
    font-family: #{fontFamily};
    font-weight: bold;

    display: inline-flex;
    align-items: center;

    height: #{size * 2.375}px;
    width: #{width}ch;

    position: relative;
    cursor: pointer;
    outline: none;
    padding: 0;

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      box-shadow: 0 0 0 #{size * 0.1875}px hsla(216,98%,51%,0.5);
    }

    &:disabled {
      filter: saturate(0) brightness(0.8);
      cursor: not-allowed;
    }
  }

  style label {
    text-align: center;
    width: 50%;
  }

  style overlay {
    position: absolute;
    bottom: #{size * 0.1875}px;
    top: #{size * 0.1875}px;

    width: calc(50% - #{size * 0.375}px);
    border-radius: #{size * 0.375}px;
    background: #FFF;

    if (checked) {
      left: calc(100% / 2 + #{size * 0.1875}px);
    } else {
      left: #{size * 0.1875}px;
    }
  }

  get width : Number {
    (Math.max(String.size(offLabel), String.size(onLabel)) + 3) * 2
  }

  fun toggle : Promise(Never, Void) {
    onChange(!checked)
  }

  fun render : Html {
    <button::base
      aria-checked={Bool.toString(checked)}
      disabled={disabled}
      onClick={toggle}
      role="checkbox">

      <div::label aria-hidden="true">
        <{ onLabel }>
      </div>

      <div::label aria-hidden="true">
        <{ offLabel }>
      </div>

      <div::overlay aria-hidden="true"/>

    </button>
  }
}
