component Ui.Link {
  connect Ui exposing { theme }

  property children : Array(Html) = []
  property type : String = "primary"
  property target : String = ""
  property label : String = ""
  property href : String = ""

  style base {
    color: {colors.background};
    text-decoration: none;
    outline: none;

    &:hover,
    &:focus {
      text-decoration: underline;
      color: {colors.focus};
    }
  }

  get colors : Ui.Theme.Color {
    case (type) {
      "secondary" => theme.colors.secondary
      "warning" => theme.colors.warning
      "success" => theme.colors.success
      "primary" => theme.colors.primary
      "danger" => theme.colors.danger

      "inherit" =>
        {
          background = "inherit",
          focus = "inherit",
          text = "inherit"
        }

      =>
        {
          background = "",
          focus = "",
          text = ""
        }
    }
  }

  fun sameOrigin : Bool {
    windowUrl.origin != url.origin
  } where {
    windowUrl =
      Window.url()

    url =
      Url.parse(href)
  }

  fun onClick (event : Html.Event) : Void {
    if (event.ctrlKey || event.button == 1 || sameOrigin()) {
      void
    } else {
      if (String.isEmpty(href)) {
        Html.Event.preventDefault(event)
      } else {
        do {
          Html.Event.preventDefault(event)
          Window.navigate(href)
        }
      }
    }
  }

  fun render : Html {
    <a::base
      onClick={onClick}
      target={target}
      href={href}>

      <{ label }>
      <{ children }>

    </a>
  }
}
