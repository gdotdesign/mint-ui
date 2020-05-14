store Ui {
  state fontFamily : String = "Arial"

  state borderRadiusCoefficient : Number = 0.165

  state primaryShadow : String = "hsla(206,97.6%,50.4%,0.3)"
  state primaryBackground : String = "#0591fc"
  state primaryText : String = "#FFF"

  state warningShadow : String = "hsla(25.5,100%,48.8%,0.3)"
  state warningBackground : String = "#f96a00"
  state warningText : String = "#FFF"

  state successShadow : String = "hsla(130.1,64.2%,41.6%, 0.3)"
  state successBackground : String = "#26ae3d"
  state successText : String = "#FFF"

  state dangerShadow : String = "hsla(0,92.5%,58.4%, 0.3)"
  state dangerBackground : String = "#f73333"
  state dangerText : String = "#FFF"

  state darkMode : Bool = false

  fun setDarkMode (value : Bool) : Promise(Never, Void) {
    next { darkMode = value }
  }

  fun setBorderRadiusCoefficient (value : Number) : Promise(Never, Void) {
    next { borderRadiusCoefficient = value }
  }

  get borderColor : String {
    if (darkMode) {
      "#2C2C2C"
    } else {
      "#E6E6E6"
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
      "#F6F6F6"
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
      "#E9E9E9"
    }
  }

  get surfaceShadow : String {
    if (darkMode) {
      "rgba(68,68,68,0.3)"
    } else {
      "rgba(238,238,238,0.3)"
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
