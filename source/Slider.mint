component Ui.Slider {
  connect Ui exposing { resolveTheme }

  /* The change event handler. */
  property onChange : Function(Number, Promise(Never, Void)) = Promise.Extra.never1

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* Wether or not the slider is disabled. */
  property disabled : Bool = false

  /* The size of the slider. */
  property size : Number = 16

  /* The maximum value for the slider. */
  property max : Number = 100

  /* The minimum value for the slider. */
  property min : Number = 0

  /* The current value of the slider. */
  property value : Number = 0

  /* The number that specifies the granularity that the value must adhere to. */
  property step : Number = 1

  /* Style for the slider. */
  style base {
    -webkit-appearance: none;
    box-sizing: border-box;

    background: transparent;
    font-size: #{size}px;
    cursor: pointer;
    height: 2.375em;
    width: 100%;
    padding: 0;
    margin: 0;

    &::-webkit-slider-thumb {
      -webkit-appearance: none;
      margin-top: -0.5em;
    }

    &::-webkit-slider-thumb,
    &::-moz-range-thumb,
    &::-ms-thumb {
      background-color: #{actualTheme.primary.s500.color};
      box-sizing: border-box;
      border-radius: 50%;
      height: 1.125em;
      width: 1.125em;
      border: 0;
    }

    &:focus::-webkit-slider-thumb,
    &:focus::-moz-range-thumb,
    &:focus::-ms-thumb {
      background-color: #{actualTheme.primary.s300.color};
    }

    &::-webkit-slider-runnable-track,
    &::-moz-range-track,
    &::-ms-track {
      border: 0.125em solid #{actualTheme.border};
      background-color: #{actualTheme.surface.color};
      box-sizing: border-box;
      border-radius: 0.3em;
      height: 0.6em;

      /* This is the progress indicator. */
      background-image: linear-gradient(#{actualTheme.primary.s700.color}, #{actualTheme.primary.s700.color});
      background-size: #{(value - min) / (max - min) * 100}% auto;
      background-repeat: repeat-y;
    }

    &:focus::-webkit-slider-runnable-track,
    &:focus::-moz-range-track,
    &:focus::-ms-track {
      box-shadow: 0 0 0 0.15em #{actualTheme.primary.shadow};
      border-color: #{actualTheme.primary.s500.color};
    }

    &:focus {
      outline: none;
    }

    &::-moz-focus-outer {
      border: 0;
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* The input event handler. */
  fun handleInput (event : Html.Event) : Promise(Never, Void) {
    event.target
    |> Dom.getValue()
    |> Number.fromString()
    |> Maybe.withDefault(0)
    |> onChange()
  }

  /* Renders the slider. */
  fun render : Html {
    <input::base
      value={Number.toString(value)}
      step={Number.toString(step)}
      max={Number.toString(max)}
      min={Number.toString(min)}
      onInput={handleInput}
      disabled={disabled}
      type="range"/>
  }
}
