/*
Indicates the current page’s location within a navigational hierarchy
with automatically added separators.
*/
component Ui.Breadcrumbs {
  connect Ui exposing { mobile }

  /* The displayed items. */
  property items : Array(Tuple(String, Html)) = []

  /* The separator between items. */
  property separator : Html = <>"/"</>

  /* The base size of the component. */
  property size : Number = 16

  /* The style of the base element. */
  style base {
    background: var(--content-color);
    color: var(--content-text);
    padding: 0.875em 2em;
    display: flex;

    font-family: var(--font-family);
    font-size: #{size}px;
    line-height: 1.2;
  }

  /* The style of the separator. */
  style separator {
    display: inline-block;
    margin: 0 0.75em;
    opacity: 0.4;
  }

  /* The style of the elements which are clickable. */
  style link {
    text-decoration: none;
    outline: none;

    &::-moz-focus-inner {
      border: 0;
    }

    &:hover,
    &:focus {
      color: var(--primary-s500-color);
      text-decoration: underline;
    }
  }

  /* The style of the a breadcrumb. */
  style breadcrumb {
    text-overflow: ellipsis;
    overflow: hidden;
    color: inherit;

    &:not(:last-child) {
      opacity: 0.75;
    }
  }

  /* Renders the component. */
  fun render : Html {
    if (mobile) {
      <></>
    } else {
      try {
        content =
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

        span =
          <span::separator aria-hidden="true">
            <{ separator }>
          </span>

        <nav::base as base>
          <{ Array.intersperse(span, content) }>
        </nav>
      }
    }
  }
}
