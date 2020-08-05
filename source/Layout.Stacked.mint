/* A vertical layout which usually good for normal websites. */
component Ui.Layout.Stacked {
  /* Content for the notification area. */
  property notification : Html = <></>

  /* Content for the breadcrumbs area. */
  property breadcrumbs : Html = <></>

  /* Content for the main area. */
  property content : Html = <></>

  /* Content for the footer area. */
  property footer : Html = <></>

  /* Content for the header area. */
  property header : Html = <></>

  /* Styles for the base element. */
  style base {
    min-height: 100vh;
    max-width: 100vw;

    grid-template-rows: #{rows};
    display: grid;

    > * {
      min-width: 0;

      &:not(:last-child) {
        border-bottom: 1px solid var(--border);
      }

      &:empty {
        display: none;
      }
    }
  }

  /* Style for the content. */
  style content {
    display: grid;
  }

  /* Returns the data for the `grid-template-rows` CSS property. */
  get rows {
    [
      {notification, "min-content"},
      {header, "min-content"},
      {breadcrumbs, "min-content"},
      {content, "1fr"},
      {footer, "min-content"}
    ]
    |> Array.map(
      (item : Tuple(Html, String)) {
        try {
          {html, ratio} =
            item

          if (Html.isNotEmpty(html)) {
            Maybe::Just(ratio)
          } else {
            Maybe::Nothing
          }
        }
      })
    |> Array.compact
    |> String.join(" ")
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      if (Html.isNotEmpty(notification)) {
        <div>
          <{ notification }>
        </div>
      }

      if (Html.isNotEmpty(header)) {
        <div>
          <{ header }>
        </div>
      }

      if (Html.isNotEmpty(breadcrumbs)) {
        <div>
          <{ breadcrumbs }>
        </div>
      }

      if (Html.isNotEmpty(content)) {
        <div::content>
          <{ content }>
        </div>
      }

      if (Html.isNotEmpty(footer)) {
        <div>
          <{ footer }>
        </div>
      }
    </div>
  }
}
