component Ui.Slider {
  connect Ui exposing { resolveTheme }

  property onChange : Function(Number, Promise(Never, Void)) = Promise.Extra.never1
  property theme : Maybe(Ui.Theme) = Maybe::Nothing
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
      border-radius: #{size * actualTheme.borderRadiusCoefficient * 0.625}px;
      background-color: #{actualTheme.primary.s500.color};
      height: #{size * 1.5}px;
      width: #{size}px;
      cursor: pointer;
      border: 0;
    }

    &:focus::-webkit-slider-thumb,
    &:focus::-moz-range-thumb,
    &:focus::-ms-thumb {
      background-color: #{actualTheme.primary.s500.color};
    }

    &::-webkit-slider-runnable-track,
    &::-moz-range-track,
    &::-ms-track {
      border-radius: 5px;
      border: #{size * 0.125}px solid #{actualTheme.border};
      background-color: #{actualTheme.content.color};
      height: #{size * 0.5}px;
    }

    &:focus::-webkit-slider-runnable-track,
    &:focus::-moz-range-track,
    &:focus::-ms-track {
      box-shadow: 0 0 0 #{size * 0.15}px #{actualTheme.primary.shadow};
      border-color: #{actualTheme.primary.s500.color};
    }

    &:focus {
      outline: none;
    }

    &::-moz-focus-outer {
      border: 0;
    }
  }

  get actualTheme {
    resolveTheme(theme)
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
