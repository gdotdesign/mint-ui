component Ui.Slider {
  property onChange : Function(Number, Promise(Never, Void)) = Promise.Extra.never1

  property disabled : Bool = false
  property max : Number = 100
  property value : Number = 0
  property step : Number = 1
  property min : Number = 0

  style base {
    -webkit-appearance: none;
    box-sizing: border-box;

    background: transparent;
    height: 34px;
    width: 100%;
    padding: 0;
    margin: 0;

    &::-webkit-slider-thumb {
      -webkit-appearance: none;
      margin-top: -6px;
    }

    &::-webkit-slider-thumb,
    &::-moz-range-thumb,
    &::-ms-thumb {
      background-color: #0659fd;
      border-radius: 6px;
      cursor: pointer;
      height: 20px;
      width: 20px;
      border: 0;
    }

    &:focus::-webkit-slider-thumb,
    &:focus::-moz-range-thumb,
    &:focus::-ms-thumb {
      background-color: #0659fd;
    }

    &::-webkit-slider-runnable-track,
    &::-moz-range-track,
    &::-ms-track {
      background-color: #ECECEC;
      border-radius: 6px;
      height: 8px;
    }

    &:focus::-webkit-slider-runnable-track,
    &:focus::-moz-range-track,
    &:focus::-ms-track {
      background-color: hsl(216,80%,81%);
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
      onChange={changed}
      type="range"/>
  }
}
