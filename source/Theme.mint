record ColorPalette.Shade {
  color : String,
  text : String
}

record ColorPalette.DynamicShade {
  color : Function(Bool, String),
  text : Function(Bool, String)
}

record ColorPalette {
  s50 : ColorPalette.Shade,
  s100 : ColorPalette.Shade,
  s200 : ColorPalette.Shade,
  s300 : ColorPalette.Shade,
  s400 : ColorPalette.Shade,
  s500 : ColorPalette.Shade,
  s600 : ColorPalette.Shade,
  s700 : ColorPalette.Shade,
  s800 : ColorPalette.Shade,
  s900 : ColorPalette.Shade
}

module ColorPalette {
  fun fromColor (color : Color) : ColorPalette {
    try {
      s50 =
        Color.mix(0.15, color, Color::HEX("FFFFFFFF"))

      s100 =
        Color.mix(0.3, color, Color::HEX("FFFFFFFF"))

      s200 =
        Color.mix(0.5, color, Color::HEX("FFFFFFFF"))

      s300 =
        Color.mix(0.7, color, Color::HEX("FFFFFFFF"))

      s400 =
        Color.mix(0.85, color, Color::HEX("FFFFFFFF"))

      s600 =
        Color.mix(0.85, color, Color::HEX("000000FF"))

      s700 =
        Color.mix(0.7, color, Color::HEX("000000FF"))

      s800 =
        Color.mix(0.5, color, Color::HEX("000000FF"))

      s900 =
        Color.mix(0.35, color, Color::HEX("000000FF"))

      {
        s900 =
          {
            text = Color.toCSSRGBA(Color.readableTextColor(s900)),
            color = Color.toCSSRGBA(s900)
          },
        s800 =
          {
            text = Color.toCSSRGBA(Color.readableTextColor(s800)),
            color = Color.toCSSRGBA(s800)
          },
        s700 =
          {
            text = Color.toCSSRGBA(Color.readableTextColor(s700)),
            color = Color.toCSSRGBA(s700)
          },
        s600 =
          {
            text = Color.toCSSRGBA(Color.readableTextColor(s600)),
            color = Color.toCSSRGBA(s600)
          },
        s500 =
          {
            text = Color.toCSSRGBA(Color.readableTextColor(color)),
            color = Color.toCSSRGBA(color)
          },
        s400 =
          {
            text = Color.toCSSRGBA(Color.readableTextColor(s400)),
            color = Color.toCSSRGBA(s400)
          },
        s300 =
          {
            text = Color.toCSSRGBA(Color.readableTextColor(s300)),
            color = Color.toCSSRGBA(s300)
          },
        s200 =
          {
            text = Color.toCSSRGBA(Color.readableTextColor(s200)),
            color = Color.toCSSRGBA(s200)
          },
        s100 =
          {
            text = Color.toCSSRGBA(Color.readableTextColor(s100)),
            color = Color.toCSSRGBA(s100)
          },
        s50 =
          {
            text = Color.toCSSRGBA(Color.readableTextColor(s50)),
            color = Color.toCSSRGBA(s50)
          }
      }
    }
  }
}

record Ui.Theme {
  primary : ColorPalette,
  warning : ColorPalette,
  success : ColorPalette,
  danger : ColorPalette,
  content : ColorPalette.DynamicShade,
  border : Function(Bool, String),
  borderRadiusCoefficient : Number,
  fontFamily : String
}

store Ui {
  state fontFamily : String = "Arial"

  state borderRadiusCoefficient : Number = 0.165

  state defaultTheme : Ui.Theme = {
    primary = ColorPalette.fromColor(Color::HEX("0591FCFF")),
    warning = ColorPalette.fromColor(Color::HEX("FFC107FF")),
    success = ColorPalette.fromColor(Color::HEX("26AE3DFF")),
    danger = ColorPalette.fromColor(Color::HEX("F44336FF")),
    borderRadiusCoefficient = 0.165,
    border =
      (darkMode : Bool) {
        if (darkMode) {
          "#2C2C2C"
        } else {
          "#EEE"
        }
      },
    content =
      {
        color =
          (darkMode : Bool) {
            if (darkMode) {
              "#333"
            } else {
              "#FFF"
            }
          },
        text =
          (darkMode : Bool) {
            if (darkMode) {
              "#CCC"
            } else {
              "#444"
            }
          }
      },
    fontFamily = "Arial"
  }

  state primaryBackground : String = "red"
  state primaryShadow : String = "maroon"
  state primaryText : String = "yellow"

  state warningShadow : String = "hsla(25.5,100%,48.8%,0.3)"
  state warningBackground : String = "#f96a00"
  state warningText : String = "#FFF"

  state successShadow : String = "hsla(130.1,64.2%,41.6%, 0.3)"
  state successBackground : String = "#26ae3d"
  state successText : String = "#FFF"

  state dangerShadow : String = "hsla(0,92.5%,58.4%, 0.3)"
  state dangerBackground : String = "#f73333"
  state dangerText : String = "#FFF"

  state mobile : Bool = Window.matchesMediaQuery("(max-width: 1000px)")
  state darkMode : Bool = false

  state mediaQueryListener = Window.addMediaQueryListener(
    "(max-width: 1000px)",
    (active : Bool) { next { mobile = active } })

  fun setDarkMode (value : Bool) : Promise(Never, Void) {
    next { darkMode = value }
  }

  fun setBorderRadiusCoefficient (value : Number) : Promise(Never, Void) {
    next { defaultTheme = { defaultTheme | borderRadiusCoefficient = value } }
  }

  get borderColor : String {
    if (darkMode) {
      "#2C2C2C"
    } else {
      "#EEE"
    }
  }

  get contentBackground : String {
    if (darkMode) {
      "#333"
    } else {
      "#FFF"
    }
  }

  get contentBackgroundFaded : String {
    if (darkMode) {
      "#3A3A3A"
    } else {
      "#F5F5F5"
    }
  }

  get contentTextFaded : String {
    if (darkMode) {
      "#999"
    } else {
      "#BBB"
    }
  }

  get contentText : String {
    if (darkMode) {
      "#CCC"
    } else {
      "#444"
    }
  }

  get surfaceBackground : String {
    if (darkMode) {
      "#444"
    } else {
      "#ECECEC"
    }
  }

  get surfaceShadow : String {
    if (darkMode) {
      "rgba(68,68,68,0.3)"
    } else {
      "rgba(170,170,170,0.3)"
    }
  }

  get surfaceText : String {
    if (darkMode) {
      "#EEE"
    } else {
      "#666"
    }
  }
}
