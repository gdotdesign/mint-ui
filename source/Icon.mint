/* A component to render SVG icons. */
component Ui.Icon {
  connect Ui exposing { resolveTheme }

  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.Extra.never1

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* Wether or not the icon can be interacted with. */
  property interactive : Bool = false

  /* Wether or not the icon is disabled. */
  property disabled : Bool = false

  /* Wether or not automatically size the icon based on the font-size. */
  property autoSize : Bool = false

  /* The opacity of the icon. */
  property opacity : Number = 1

  /* The actual SVG icon. */
  property icon : Html = <></>

  /* The size of the icon. */
  property size : Number = 16

  /* If provided the icon will behave as an anchor to the specified URL. */
  property href : String = ""

  /* The styles for the icon. */
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

  /* The style for the link. */
  style link {
    color: inherit;
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  fun render : Html {
    if (String.Extra.isNotEmpty(href)) {
      <a::base::link href={href}>
        <{ icon }>
      </a>
    } else {
      <div::base onClick={onClick}>
        <{ icon }>
      </div>
    }
  }
}
