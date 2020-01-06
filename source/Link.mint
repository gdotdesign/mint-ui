component Ui.Link {
  connect Ui exposing { theme }

  property children : Array(Html) = []
  property type : String = "primary"
  property target : String = ""
  property label : String = ""
  property href : String = ""

  style base {
    color: #{colors.background};
    text-decoration: none;
    outline: none;

    &:hover,
    &:focus {
      text-decoration: underline;
      color: #{colors.focus};
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

  fun render : Html {
    <a::base
      target={target}
      href={href}>

      <{ label }>
      <{ children }>

    </a>
  }
}
