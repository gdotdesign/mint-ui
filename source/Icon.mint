component Ui.Icon {
  connect Ui exposing { resolveTheme }

  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1
  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property interactive : Bool = false
  property disabled : Bool = false
  property autoSize : Bool = false
  property opacity : Number = 1
  property icon : Html = <></>
  property size : Number = 16
  property href : String = ""

  style base {
    justify-content: center;
    align-items: center;
    display: flex;

    svg {
      opacity: #{opacity};
      fill: currentColor;

      if (interactive) {
        pointer-events: auto;
        cursor: pointer;
      } else {
        pointer-events: none;
        cursor: auto;
      }

      if (disabled) {
        pointer-events: none;
        opacity: 0.5;
      }

      &:hover {
        color: #{actualTheme.primary.s500.color};
      }

      if (autoSize) {
        height: 1em;
        width: 1em;
      } else {
        height: #{size}px;
        width: #{size}px;
      }
    }
  }

  style link {
    color: inherit;
  }

  get actualTheme {
    resolveTheme(theme)
  }

  fun render : Html {
    if (String.Extra.isNotEmpty(href)) {
      <a::base::link href={href}>
        <{ icon }>
      </a>
    } else {
      <div::base>
        <{ icon }>
      </div>
    }
  }
}
