record ColorPalette.Shade {
  color : String,
  text : String
}

record ColorPalette.DynamicShade {
  color : Function(Bool, String),
  text : Function(Bool, String)
}

record ColorPalette {
  shadow : String,
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
        shadow = Color.toCSSRGBA(Color.setAlpha(25, color)),
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
  contentLight : ColorPalette.Shade,
  contentLightFaded : ColorPalette.Shade,
  contentDark : ColorPalette.Shade,
  contentDarkFaded : ColorPalette.Shade,
  surfaceLight : ColorPalette.Shade,
  surfaceDark : ColorPalette.Shade,
  borderDark : String,
  borderLight : String,
  borderRadiusCoefficient : Number,
  fontFamily : String
}

record Ui.Theme.Resolved {
  primary : ColorPalette,
  warning : ColorPalette,
  success : ColorPalette,
  danger : ColorPalette,
  content : ColorPalette.Shade,
  contentFaded : ColorPalette.Shade,
  surface : ColorPalette.Shade,
  border : String,
  borderRadiusCoefficient : Number,
  fontFamily : String
}

store Ui {
  state fontFamily : String = "Arial"

  state borderRadiusCoefficient : Number = 0.16

  fun or (value : x, maybe : Maybe(a)) {
    Maybe.withDefault(value, maybe)
  }

  fun resolveTheme (theme : Maybe(Ui.Theme)) {
    try {
      resolved =
        Maybe.withDefault(defaultTheme, theme)

      if (darkMode) {
        {
          primary = resolved.primary,
          warning = resolved.warning,
          success = resolved.success,
          danger = resolved.danger,
          content = resolved.contentDark,
          contentFaded = resolved.contentDarkFaded,
          surface = resolved.surfaceDark,
          border = resolved.borderDark,
          borderRadiusCoefficient = resolved.borderRadiusCoefficient,
          fontFamily = resolved.fontFamily
        }
      } else {
        {
          primary = resolved.primary,
          warning = resolved.warning,
          success = resolved.success,
          danger = resolved.danger,
          content = resolved.contentLight,
          contentFaded = resolved.contentLightFaded,
          surface = resolved.surfaceLight,
          border = resolved.borderLight,
          borderRadiusCoefficient = resolved.borderRadiusCoefficient,
          fontFamily = resolved.fontFamily
        }
      }
    }
  }

  state defaultTheme : Ui.Theme = {
    primary = ColorPalette.fromColor(Color::HEX("0591FCFF")),
    warning = ColorPalette.fromColor(Color::HEX("FFC107FF")),
    success = ColorPalette.fromColor(Color::HEX("26AE3DFF")),
    danger = ColorPalette.fromColor(Color::HEX("F44336FF")),
    contentLight =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("FFFFFFFF"))),
        color = Color.toCSSRGBA(Color::HEX("FFFFFFFF"))
      },
    contentLightFaded =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("F9F9F9FF"))),
        color = Color.toCSSRGBA(Color::HEX("F9F9F9FF"))
      },
    contentDark =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("333333FF"))),
        color = Color.toCSSRGBA(Color::HEX("333333FF"))
      },
    contentDarkFaded =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("2F2F2FFF"))),
        color = Color.toCSSRGBA(Color::HEX("2F2F2FFF"))
      },
    surfaceLight =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("F0F0F0"))),
        color = Color.toCSSRGBA(Color::HEX("F0F0F0"))
      },
    surfaceDark =
      {
        text = Color.toCSSRGBA(Color.readableTextColor(Color::HEX("3A3A3AFF"))),
        color = Color.toCSSRGBA(Color::HEX("3A3A3AFF"))
      },
    borderLight = "#E9E9E9",
    borderDark = "#2C2C2C",
    borderRadiusCoefficient = 0.16,
    fontFamily = "Arial"
  }

  state primaryBackground : String = "purple"
  state primaryShadow : String = "purple"
  state primaryText : String = "white"

  state warningShadow : String = "blue"
  state warningBackground : String = "blue"
  state warningText : String = "white"

  state successShadow : String = "cyan"
  state successBackground : String = "cyan"
  state successText : String = "white"

  state dangerShadow : String = "black"
  state dangerBackground : String = "black  "
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

  fun disabledHandler (
    disabled : Bool,
    handler : Function(a, Promise(Never, Void))
  ) : Function(a, Promise(Never, Void)) {
    if (disabled) {
      Promise.Extra.never1()
    } else {
      handler
    }
  }

  get borderColor : String {
    if (darkMode) {
      "CadetBlue"
    } else {
      "CadetBlue"
    }
  }

  get contentBackground : String {
    if (darkMode) {
      "AntiqueWhite"
    } else {
      "AntiqueWhite"
    }
  }

  get contentBackgroundFaded : String {
    if (darkMode) {
      "Aquamarine"
    } else {
      "Aquamarine"
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
      "Crimson"
    } else {
      "Crimson"
    }
  }

  get surfaceBackground : String {
    if (darkMode) {
      "DarkSlateGray"
    } else {
      "DarkSlateGray"
    }
  }

  get surfaceShadow : String {
    if (darkMode) {
      "DarkSlateGray"
    } else {
      "DarkSlateGray)"
    }
  }

  get surfaceText : String {
    if (darkMode) {
      "Fuchsia"
    } else {
      "Fuchsia"
    }
  }
}
