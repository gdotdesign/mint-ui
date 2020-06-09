component Ui.Theme {
  connect Ui exposing { darkMode }

  property children : Array(Html) = []
  property primary : Color = Color::HEX("0591FCFF")
  property success : Color = Color::HEX("26AE3DFF")
  property danger : Color = Color::HEX("F73333FF")
  property warning : Color = Color::HEX("FFC107FF")
  property content : Color = Color::HEX("888888FF")

  style base {
    --border-radius-coefficient: 0.15;
    --font-family: Arial;

    --border-color: #{borderColor};
  }

  get borderColor : String {
    if (darkMode) {
      /* #2C2C2C */
      "red"
    } else {
      /* #EEE */
      "blue"
    }
  }

  fun render : Html {
    try {
      surfaceColor =
        if (darkMode) {
          Color::HEX("444444FF")
        } else {
          Color::HEX("ECECECFF")
        }

      types =
        [
          {"primary", primary},
          {"success", success},
          {"danger", danger},
          {"surface", surfaceColor},
          {"warning", warning},
          {"content", content}
        ]

      values =
        if (darkMode) {
          [
            {"900", 0.4},
            {"800", 0.3},
            {"700", 0.2},
            {"600", 0.1},
            {"500", 0},
            {"400", -0.1},
            {"300", -0.3},
            {"200", -0.4},
            {"100", -0.5},
            {"50", -0.65}
          ]
        } else {
          [
            {"900", -0.4},
            {"800", -0.3},
            {"700", -0.2},
            {"600", -0.1},
            {"500", 0},
            {"400", 0.1},
            {"300", 0.2},
            {"200", 0.5},
            {"100", 0.75},
            {"50", 0.95}
          ]
        }

      primaryVars =
        for (item of types) {
          for (item2 of values) {
            try {
              {name, baseColor} =
                item

              {valueName, value} =
                item2

              color =
                Color.lighten(value, baseColor)

              [
                {"--#{name}-#{valueName}", Color.toCSSRGBA(color)},
                {"--#{name}-#{valueName}-text", Color.toCSSRGBA(Color.readableTextColor(color))}
              ]
            }
          }
        }
        |> Array.concat
        |> Array.concat

      vars =
        Array.reduce(
          Map.empty(),
          (
            memo : Map(String, String),
            item : Tuple(String, String)
          ) : Map(String, String) {
            try {
              {name, value} =
                item

              Map.set(name, value, memo)
            }
          },
          primaryVars)

      <div::base style={vars}>
        <{ children }>
      </div>
    }
  }
}
