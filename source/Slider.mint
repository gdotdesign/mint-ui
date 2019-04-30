component Ui.Slider {
  connect Ui exposing { theme }

  property onChange : Function(Number, a) = (value : Number) : Void { void }
  property disabled : Bool = false
  property max : Number = 100
  property value : Number = 0
  property step : Number = 1
  property min : Number = 0

  style base {
    -webkit-appearance: none;
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
      background-color: {theme.colors.primary.background};
      border-radius: 50%;
      cursor: pointer;
      height: 20px;
      width: 20px;
      border: 0;
    }

    &:focus::-webkit-slider-thumb,
    &:focus::-moz-range-thumb,
    &:focus::-ms-thumb {
      background-color: {theme.hover.color};
    }

    &::-webkit-slider-runnable-track,
    &::-moz-range-track,
    &::-ms-track {
      background-color: {theme.colors.input.background};
      border: 1px solid {theme.border.color};
      border-radius: {theme.border.radius};
      height: 8px;
    }

    &:focus::-webkit-slider-runnable-track,
    &:focus::-moz-range-track,
    &:focus::-ms-track {
      box-shadow: 0 0 2px {theme.outline.fadedColor} inset,
                  0 0 2px {theme.outline.fadedColor};

      border-color: {theme.outline.color};
    }

    &:focus {
      outline: none;
    }

    &::-moz-focus-outer {
      border: 0;
    }
  }

  fun changed (event : Html.Event) : Void {
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
