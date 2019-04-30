enum Ui.Button.Kind {
  Primary
  Secondary
  Warning
  Success
  Danger
}

component Ui.Button {
  connect Ui exposing { theme }

  property onMouseDown : Function(Html.Event, Promise(Never, Void)) =
    (event : Html.Event) : Promise(Never, Void) { Promise.never() }

  property onMouseUp : Function(Html.Event, Promise(Never, Void)) =
    (event : Html.Event) : Promise(Never, Void) { Promise.never() }

  property onClick : Function(Html.Event, Promise(Never, Void)) =
    (event : Html.Event) : Promise(Never, Void) { Promise.never() }

  property type : Ui.Button.Kind = Ui.Button.Kind::Primary
  property children : Array(Html) = []
  property disabled : Bool = false
  property outline : Bool = false
  property size : Number = 16

  style styles {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    font-family: {theme.fontFamily};
    font-size: {size}px;
    font-weight: bold;
    user-select: none;

    white-space: nowrap;
    cursor: pointer;
    outline: none;

    height: {size * 2.42857142857}px;
    padding: 0 {size * 1.5}px;

    justify-content: center;
    align-items: center;
    display: inline-flex;

    background: {background};
    color: {color};

    border-radius: {theme.border.radius};
    border-width: {size * 0.125}px;
    border-color: {borderColor};
    border-style: solid;

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      outline: 2px solid {colors.background};
      outline-offset: 2px;
    }

    &:disabled {
      filter: saturate(0) brightness(0.8);
      cursor: not-allowed;
    }
  }

  style gutter {
    width: {size * 1.42857142857}px;
  }

  get background : String {
    if (outline) {
      "transparent"
    } else {
      colors.background
    }
  }

  get color : String {
    if (outline) {
      colors.background
    } else {
      colors.text
    }
  }

  get borderColor : String {
    if (outline) {
      colors.background
    } else {
      "transparent"
    }
  }

  get colors : Ui.Theme.Color {
    case (type) {
      Ui.Button.Kind::Secondary => theme.colors.secondary
      Ui.Button.Kind::Warning => theme.colors.warning
      Ui.Button.Kind::Success => theme.colors.success
      Ui.Button.Kind::Primary => theme.colors.primary
      Ui.Button.Kind::Danger => theme.colors.danger
    }
  }

  fun render : Html {
    <button::styles
      onMouseDown={onMouseDown}
      onMouseUp={onMouseUp}
      disabled={disabled}
      onClick={onClick}>

      <{
        children
        |> Array.intersperse(<div::gutter/>)
      }>

    </button>
  }
}
