record Ui.Theme.Color {
  background : String,
  focus : String,
  text : String
}

record Ui.Theme.SingleColor {
  color : String
}

record Ui.Theme.Outline {
  fadedColor : String,
  color : String
}

record Ui.Theme.Border {
  radius : String,
  color : String
}

record Ui.Theme.Colors {
  inputSecondary : Ui.Theme.Color,
  secondary : Ui.Theme.Color,
  disabled : Ui.Theme.Color,
  primary : Ui.Theme.Color,
  success : Ui.Theme.Color,
  warning : Ui.Theme.Color,
  danger : Ui.Theme.Color,
  input : Ui.Theme.Color
}

record Ui.Theme {
  hover : Ui.Theme.SingleColor,
  outline : Ui.Theme.Outline,
  border : Ui.Theme.Border,
  colors : Ui.Theme.Colors,
  fontFamily : String
}

store Ui {
  state theme : Ui.Theme = {
    fontFamily =
      "-apple-system, system-ui, BlinkMacSystemFont, Segoe UI, " \
      "Roboto, Helvetica Neue, Arial, sans-serif",
    colors =
      {
        warning =
          {
            background = "#FF9730",
            focus = "#ffb163",
            text = "#FFF"
          },
        danger =
          {
            background = "#E04141",
            focus = "#e76d6d",
            text = "#FFF"
          },
        success =
          {
            background = "#3fb543",
            focus = "#60c863",
            text = "#FFF"
          },
        secondary =
          {
            background = "#222",
            focus = "#333",
            text = "#FFF"
          },
        primary =
          {
            background = "#158DD8",
            focus = "#3caaef",
            text = "#FFF"
          },
        disabled =
          {
            background = "#D7D7D7",
            text = "#9A9A9A",
            focus = ""
          },
        inputSecondary =
          {
            background = "#F3F3F3",
            text = "#616161",
            focus = ""
          },
        input =
          {
            background = "#FDFDFD",
            text = "#606060",
            focus = "#FFF"
          }
      },
    hover = { color = "#6cc4ef" },
    outline =
      {
        fadedColor = "hsla(191, 100%, 50%, 0.5)",
        color = "hsla(191, 100%, 50%, 1)"
      },
    border =
      {
        color = "#DDD",
        radius = "2px"
      }
  }

  fun setFontFamily (fontFamily : String) : Void {
    next { theme = updatedTheme }
  } where {
    updatedTheme =
      { theme | fontFamily = fontFamily }
  }

  fun setPrimaryBackground (color : String) : Void {
    next { theme = updatedTheme }
  } where {
    colors =
      theme.colors

    primary =
      colors.primary

    updatedPrimary =
      { primary | background = color }

    updatedColors =
      { colors | primary = updatedPrimary }

    updatedTheme =
      { theme | colors = updatedColors }
  }
}
