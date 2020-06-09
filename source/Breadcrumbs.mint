component Ui.Breadcrumbs {
  connect Ui exposing {
    defaultTheme,
    darkMode,
    mobile
  }

  property separator : Html =
    <>
      "/"
    </>

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property items : Array(Tuple(String, Html)) = []
  property size : Number = 16

  get actualTheme {
    Maybe.withDefault(defaultTheme, theme)
  }

  style base {
    background: #{actualTheme.content.color(darkMode)};
    color: #{actualTheme.content.text(darkMode)};
    font-family: #{actualTheme.fontFamily};
    padding: 0.875em 2em;

    font-size: #{size}px;
    white-space: nowrap;
  }

  style separator {
    display: inline-block;
    margin: 0 0.75em;
    opacity: 0.4;
  }

  style breadcrumb {
    text-decoration: none;
    color: inherit;
    outline: none;

    &:not(:last-child) {
      opacity: 0.75;
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:hover,
    &:focus {
      color: #{actualTheme.primary.s500.color};
    }
  }

  get content : Array(Html) {
    for (item of items) {
      try {
        {href, content} =
          item

        if (String.isEmpty(href)) {
          <span aria-label="breadcrumb">
            <{ content }>
          </span>
        } else {
          <a::breadcrumb
            aria-label="breadcrumb"
            href={href}>

            <{ content }>

          </a>
        }
      }
    }
  }

  fun render : Html {
    if (mobile) {
      <></>
    } else {
      try {
        span =
          <span::separator aria-hidden="true">
            <{ separator }>
          </span>

        <nav::base>
          <{ Array.intersperse(span, content) }>
        </nav>
      }
    }
  }
}
