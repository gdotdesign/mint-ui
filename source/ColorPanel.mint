component Ui.ColorPanel {
  connect Ui exposing { darkMode }

  property onChange : Function(Color, Promise(Never, Void)) = Promise.never1
  property onEnd : Function(Promise(Never, Void)) = Promise.never
  property value : Color = Color::HEX("000000FF")

  state alphaDragging : Bool = false
  state rectDragging : Bool = false
  state hueDragging : Bool = false

  property size : Number = 16

  use Provider.Mouse {
    clicks = Promise.never1,
    moves = moves,
    ups = ups
  } when {
    rectDragging || hueDragging || alphaDragging
  }

  style base {
    grid-template-areas: "rect hue" "alpha alpha";
    grid-template-columns: 13em 1em;
    grid-template-rows: 13em 1em;
    grid-gap: 1em;
    display: grid;

    font-size: #{size}px;

    border-radius: calc(1em * var(--border-radius-coefficient));
    background-color: var(--content-color);
    border: 0.125em solid var(--border);
    user-select: none;
    padding: 1em;
  }

  style rect {
    background-image: linear-gradient(0deg, #000 0%, transparent 100%),
                      linear-gradient(90deg, #FFF 0%, rgba(0,0,0,0) 100%);

    background-color: hsl(#{Color.getHue(value)}, 100%, 50%);
    border: 1px solid var(--border);
    background-clip: content-box;
    border-radius: 0.125em;
    position: relative;
    grid-area: rect;
    cursor: move;
  }

  style handle {
    background: rgba(102, 102, 102, 0.6);
    pointer-events: none;
    position: absolute;

    if (darkMode) {
      box-shadow: 0 0 0 1px rgba(255,255,255,0.75);
    } else {
      box-shadow: 0 0 0 1px rgba(0,0,0,0.75);
    }
  }

  style rect-handle {
    transform: translate3d(0,0,0) translate(-50%,-50%);
    height: 0.5em;
    width: 0.5em;

    left: #{Color.getSaturation(value)}%;
    top: #{100 - Color.getValue(value)}%;
  }

  style hue-handle {
    transform: translate3d(0,0,0) translateY(-50%);
    top: #{Color.getHue(value) / 360 * 100}%;
    border-radius: 0.125em;
    right: -0.125em;
    left: -0.125em;
    height: 0.4em;
  }

  style alpha-handle {
    transform: translate3d(0,0,0) translateX(-50%);
    left: #{Color.getAlpha(value)}%;
    border-radius: 0.125em;
    bottom: -0.125em;
    top: -0.125em;
    width: 0.4em;
  }

  style hue {
    background: linear-gradient(to bottom, #F00 0%, #FF0 17%, #0F0 33%,#0FF 50%, #00F 67%, #F0F 83%, #F00 100%);
    position: relative;
    cursor: row-resize;
    border-radius: 0.125em;
    border: 1px solid var(--border);
    background-clip: content-box;
    grid-area: hue;
  }

  style alpha {
    border-radius: 0.125em;

    background-image: #{alphaGradient},
                      linear-gradient(45deg, #F5F5F5 25%, transparent 25%, transparent 75%, #F5F5F5 75%, #F5F5F5),
                      linear-gradient(45deg, #F5F5F5 25%, transparent 25%, transparent 75%, #F5F5F5 75%, #F5F5F5);

    background-size: 100%, 18px 18px, 18px 18px;
    background-position: 0 0, 0 0, 9px 9px;
    background-color: #DDD;
    border: 1px solid var(--border);
    background-clip: content-box;
    position: relative;
    cursor: col-resize;

    grid-area: alpha;
  }

  style parts {
    grid-template-columns: 5em repeat(4, 1fr);
    grid-column: 1 / 3;
    grid-gap: 6px;
    display: grid;

    input {
      text-align: center;
      font-weight: bold;
      padding: 0;
    }
  }

  get alphaGradient : String {
    try {
      color =
        value
        |> Color.setAlpha(100)
        |> Color.toCSSRGBA()

      "linear-gradient(90deg, transparent, " + color + ")"
    }
  }

  fun ups (event : Html.Event) : Promise(Never, Void) {
    sequence {
      next
        {
          alphaDragging = false,
          rectDragging = false,
          hueDragging = false
        }

      onEnd()
    }
  }

  fun moves (event : Html.Event) : Promise(Never, Void) {
    if (rectDragging) {
      case (rectElement) {
        Maybe::Just element =>
          try {
            dimensions =
              Dom.getDimensions(element)

            saturation =
              (event.pageX - `window.pageXOffset` - dimensions.left) / dimensions.width
              |> Math.clamp(0, 1)

            val =
              (event.pageY - `window.pageYOffset` - dimensions.top) / dimensions.height
              |> Math.clamp(0, 1)

            nextValue =
              value
              |> Color.setSaturation(saturation * 100)
              |> Color.setValue((1 - val) * 100)

            onChange(nextValue)
          }

        => next {  }
      }
    } else if (hueDragging) {
      case (hueElement) {
        Maybe::Just element =>
          try {
            dimensions =
              Dom.getDimensions(element)

            hue =
              (event.pageY - `window.pageYOffset` - dimensions.top) / dimensions.height
              |> Math.clamp(0, 1)

            nextValue =
              value
              |> Color.setHue(hue * 360)

            onChange(nextValue)
          }

        => next {  }
      }
    } else if (alphaDragging) {
      case (alphaElement) {
        Maybe::Just element =>
          try {
            dimensions =
              Dom.getDimensions(element)

            alpha =
              (event.pageX - `window.pageXOffset` - dimensions.left) / dimensions.width
              |> Math.clamp(0, 1)

            nextValue =
              value
              |> Color.setAlpha(Math.round(alpha * 100))

            onChange(nextValue)
          }

        => next {  }
      }
    } else {
      next {  }
    }
  }

  fun handleRectMouseDown (event : Html.Event) : Promise(Never, Void) {
    try {
      Html.Event.preventDefault(event)
      next { rectDragging = true }
    }
  }

  fun handleHueMouseDown (event : Html.Event) : Promise(Never, Void) {
    try {
      Html.Event.preventDefault(event)
      next { hueDragging = true }
    }
  }

  fun handleAlphaMouseDown (event : Html.Event) : Promise(Never, Void) {
    try {
      Html.Event.preventDefault(event)
      next { alphaDragging = true }
    }
  }

  fun handleHue (raw : String) : Promise(Never, Void) {
    sequence {
      hue =
        raw
        |> Number.fromString()
        |> Maybe.withDefault(0)

      value
      |> Color.setHue(hue)
      |> onChange
    }
  }

  fun handleValue (raw : String) : Promise(Never, Void) {
    sequence {
      nextValue =
        raw
        |> Number.fromString()
        |> Maybe.withDefault(0)

      value
      |> Color.setValue(nextValue)
      |> onChange
    }
  }

  fun handleSaturation (raw : String) : Promise(Never, Void) {
    sequence {
      saturation =
        raw
        |> Number.fromString()
        |> Maybe.withDefault(0)

      value
      |> Color.setSaturation(saturation)
      |> onChange
    }
  }

  fun handleAlpha (raw : String) : Promise(Never, Void) {
    sequence {
      alpha =
        raw
        |> Number.fromString()
        |> Maybe.withDefault(0)

      value
      |> Color.setAlpha(alpha)
      |> onChange
    }
  }

  fun render : Html {
    <div::base>
      <div::alpha as alphaElement onMouseDown={handleAlphaMouseDown}>
        <div::handle::alpha-handle/>
      </div>

      <div::rect as rectElement onMouseDown={handleRectMouseDown}>
        <div::handle::rect-handle/>
      </div>

      <div::hue as hueElement onMouseDown={handleHueMouseDown}>
        <div::handle::hue-handle/>
      </div>

      <div::parts>
        <Ui.Input
          value={Color.toCSSHex(value)}
          size={size * 0.75}/>

        <Ui.Input
          value={Number.toString(Math.round(Color.getHue(value)))}
          onChange={handleHue}
          size={size * 0.75}/>

        <Ui.Input
          value={Number.toString(Math.round(Color.getSaturation(value)))}
          onChange={handleSaturation}
          size={size * 0.75}/>

        <Ui.Input
          value={Number.toString(Math.round(Color.getValue(value)))}
          onChange={handleValue}
          size={size * 0.75}/>

        <Ui.Input
          value={Number.toString(Color.getAlpha(value))}
          onChange={handleAlpha}
          size={size * 0.75}/>
      </div>
    </div>
  }
}
