/* Describes the types of button that can exists. */
enum Ui.Button.Kind {
  Primary
  Warning
  Success
  Danger
}

/* A generic button component with a label and icon fields. */
component Ui.Button {
  connect Ui exposing { fontFamily }

  property onMouseDown : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onMouseUp : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  property type : Ui.Button.Kind = Ui.Button.Kind::Primary
  property disabled : Bool = false
  property size : Number = 16

  property rightIcon : String = ""
  property leftIcon : String = ""
  property label : String = ""

  style styles {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    font-family: #{fontFamily};
    font-size: #{size}px;
    font-weight: bold;
    user-select: none;

    white-space: nowrap;
    position: relative;
    cursor: pointer;
    outline: none;

    padding: 0 #{size * 1.2}px;
    height: #{size * 2.375}px;

    justify-content: center;
    display: inline-flex;
    align-items: center;

    color: #FFF;

    case (type) {
      Ui.Button.Kind::Warning => background: #f96a00;
      Ui.Button.Kind::Success => background: #26ae3d;
      Ui.Button.Kind::Primary => background: #0659fd;
      Ui.Button.Kind::Danger => background: #f73333;
    }

    border-radius: #{size * 0.5}px;
    border: 0;

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      case (type) {
        Ui.Button.Kind::Success => box-shadow: 0 0 0 #{size * 0.1875}px hsl(130.1,64.2%,41.6%, 0.5);
        Ui.Button.Kind::Warning => box-shadow: 0 0 0 #{size * 0.1875}px hsl(25.5,100%,48.8%,0.5);
        Ui.Button.Kind::Danger => box-shadow: 0 0 0 #{size * 0.1875}px hsl(0,92.5%,58.4%, 0.5);
        Ui.Button.Kind::Primary => box-shadow: 0 0 0 #{size * 0.1875}px hsla(216,98%,51%,0.5);
      }
    }

    &:hover {
      filter: brightness(0.8) contrast(1.5);
    }

    &:disabled {
      filter: saturate(0) brightness(0.8);
      cursor: not-allowed;
    }

    > * + * {
      margin-left: #{size * 0.5}px;
    }
  }

  style gutter {
    width: #{size * 0.5}px;
  }

  fun render : Html {
    <button::styles as button
      onMouseDown={onMouseDown}
      onMouseUp={onMouseUp}
      disabled={disabled}
      onClick={onClick}>

      if (String.Extra.isNotEmpty(leftIcon)) {
        <Octicon
          icon={leftIcon}
          size={size}/>
      }

      if (String.Extra.isNotEmpty(label)) {
        <span>
          <{ label }>
        </span>
      }

      if (String.Extra.isNotEmpty(rightIcon)) {
        <Octicon
          icon={rightIcon}
          size={size}/>
      }

    </button>
  }
}
