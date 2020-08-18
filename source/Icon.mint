/* A component to render SVG icons. */
component Ui.Icon {
  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.never1

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

    &:focus,
    &:hover {
      if (interactive && !disabled) {
        color: var(--primary-s500-color);
      }
    }

    if (disabled) {
      cursor: not-allowed;
    }

    svg {
      opacity: #{opacity};
      fill: currentColor;

      if (interactive && !disabled) {
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

  /* The style for the button. */
  style button {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;
    background: none;
    color: inherit;
    outline: 0;
    padding: 0;
    border: 0;
    margin: 0;
  }

  fun render : Html {
    try {
      if (String.isNotBlank(href)) {
        <a::base::link href={href}>
          <{ icon }>
        </a>
      } else if (interactive && !disabled) {
        <button::base::button onClick={onClick}>
          <{ icon }>
        </button>
      } else {
        <div::base onClick={onClick}>
          <{ icon }>
        </div>
      }
    }
  }
}
