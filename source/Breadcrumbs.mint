component Ui.Breadcrumbs {
  connect Ui exposing { resolveTheme, mobile }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property items : Array(Tuple(String, Html)) = []
  property separator : Html = <>"/"</>
  property size : Number = 16

  style base {
    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};
    padding: 0.875em 2em;
    display: flex;

    font-family: #{actualTheme.fontFamily};
    font-size: #{size}px;
    line-height: 1;
  }

  style separator {
    display: inline-block;
    margin: 0 0.75em;
    opacity: 0.4;
  }

  style link {
    text-decoration: none;
    outline: none;

    &::-moz-focus-inner {
      border: 0;
    }

    &:hover,
    &:focus {
      color: #{actualTheme.primary.s500.color};
      text-decoration: underline;
    }
  }

  style breadcrumb {
    text-overflow: ellipsis;
    overflow: hidden;
    color: inherit;

    &:not(:last-child) {
      opacity: 0.75;
    }
  }

  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  get content : Array(Html) {
    for (item of items) {
      try {
        {href, content} =
          item

        if (String.isEmpty(href)) {
          <span::breadcrumb aria-label="breadcrumb">
            <{ content }>
          </span>
        } else {
          <a::breadcrumb::link
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
