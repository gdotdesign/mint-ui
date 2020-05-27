component Ui.Breadcrumbs {
  connect Ui exposing {
    primaryBackground,
    borderColor,
    contentBackground,
    contentText,
    fontFamily,
    mobile
  }

  property items : Array(Tuple(String, Html)) = []

  property separator : Html =
    <>
      "/"
    </>

  property size : Number = 16

  style base {
    padding: #{size * 0.875}px #{size * 2}px;
    font-family: #{fontFamily};
    background: #{contentBackground};
    color: #{contentText};

    font-size: #{size}px;
    white-space: nowrap;
  }

  style separator {
    margin: 0 #{size * 0.75}px;
    display: inline-block;
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
      color: #{primaryBackground};
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
