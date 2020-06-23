component Ui.Layout.Stacked {
  connect Ui exposing { resolveTheme }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property breadcrumbs : Html = <></>
  property content : Html = <></>
  property footer : Html = <></>
  property header : Html = <></>

  style base {
    min-height: 100vh;
    max-width: 100vw;

    grid-template-rows: #{rows};
    display: grid;

    > * {
      min-width: 0;

      &:not(:last-child) {
        border-bottom: 1px solid #{actualTheme.border};
      }

      &:empty {
        display: none;
      }
    }
  }

  style content {
    display: grid;
    flex: 1;
  }

  style item {
    flex: 0 0 auto;
  }

  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  get rows {
    [
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

          if (Html.Extra.isNotEmpty(html)) {
            Maybe::Just(ratio)
          } else {
            Maybe::Nothing
          }
        }
      })
    |> Array.compact
    |> String.join(" ")
  }

  fun render : Html {
    <div::base>
      if (Html.Extra.isNotEmpty(header)) {
        <div::item>
          <{ header }>
        </div>
      }

      if (Html.Extra.isNotEmpty(breadcrumbs)) {
        <div::item>
          <{ breadcrumbs }>
        </div>
      }

      if (Html.Extra.isNotEmpty(content)) {
        <div::content>
          <{ content }>
        </div>
      }

      if (Html.Extra.isNotEmpty(footer)) {
        <div::item>
          <{ footer }>
        </div>
      }
    </div>
  }
}
