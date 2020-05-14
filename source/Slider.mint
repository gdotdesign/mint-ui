component Ui.Slider {
  connect Ui exposing {
    borderRadiusCoefficient,
    primaryBackground,
    surfaceBackground,
    contentBackground,
    primaryShadow,
    borderColor
  }

  property onChange : Function(Number, Promise(Never, Void)) = Promise.Extra.never1

  property disabled : Bool = false
  property size : Number = 16
  property max : Number = 100
  property value : Number = 0
  property step : Number = 1
  property min : Number = 0

  style base {
    -webkit-appearance: none;
    box-sizing: border-box;

    height: #{size * 2.375}px;
    background: transparent;
    width: 100%;
    padding: 0;
    margin: 0;

    &::-webkit-slider-thumb {
      margin-top: -#{size * 0.5}px;
      -webkit-appearance: none;
    }

    &::-webkit-slider-thumb,
    &::-moz-range-thumb,
    &::-ms-thumb {
      border-radius: #{size * borderRadiusCoefficient * 0.625}px;
      background-color: #{primaryBackground};
      height: #{size * 1.5}px;
      width: #{size}px;
      cursor: pointer;
      border: 0;
    }

    &:focus::-webkit-slider-thumb,
    &:focus::-moz-range-thumb,
    &:focus::-ms-thumb {
      background-color: #{primaryBackground};
    }

    &::-webkit-slider-runnable-track,
    &::-moz-range-track,
    &::-ms-track {
      border-radius: 5px;
      border: #{size * 0.125}px solid #{borderColor};
      background-color: #{contentBackground};
      height: #{size * 0.5}px;
    }

    &:focus::-webkit-slider-runnable-track,
    &:focus::-moz-range-track,
    &:focus::-ms-track {
      box-shadow: 0 0 0 #{size * 0.15}px #{primaryShadow};
      border-color: #{primaryBackground};
    }

    &:focus {
      outline: none;
    }

    &::-moz-focus-outer {
      border: 0;
    }
  }

  fun changed (event : Html.Event) : Promise(Never, Void) {
    event.target
    |> Dom.getValue()
    |> Number.fromString()
    |> Maybe.withDefault(0)
    |> onChange()
  }

  fun render : Html {
    <input::base
      value={Number.toString(value)}
      step={Number.toString(step)}
      max={Number.toString(max)}
      min={Number.toString(min)}
      disabled={disabled}
      onInput={changed}
      type="range"/>
  }
}
