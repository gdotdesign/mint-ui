/* A component to display and example, controls and source code of a component. */
component Ui.Example {
  connect Ui exposing { resolveTheme }

  /* Controls the horizontal spacing between the elements. */
  property horizontalSpacing : Number = 0

  /* Controls the vertical spacing between the elements. */
  property verticalSpacing : Number = 0

  /* Wether or not the example fills the demo area. */
  property fill : Bool = false

  /* The controls. */
  property controls : Function(Html) = () { <></> }

  /* Controls when to use a one column layout. */
  property breakpoint : Number = 1000

  /* The theme for the hint. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The example and it's source code to display. */
  property data : Tuple(Html, String)

  /* The size of the component. */
  property size : Number = 16

  state mobile : Bool = false

  use Provider.ElementSize {
    changes = (dimensions : Dom.Dimensions) { next { mobile = dimensions.width < breakpoint } },
    element = base
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* the style for the base. */
  style base {
    box-shadow: 0 0 0.0625em 0.0625em #{actualTheme.border},
                0 0 0 0.25em #{actualTheme.contentFaded.color};

    border-radius: #{1.5625 * actualTheme.borderRadiusCoefficient}em;
    font-size: #{size}px;
    position: relative;
    display: grid;

    if (mobile) {
      grid-template-columns: 1fr;
    } else {
      grid-template-columns: 1fr min-content;
    }
  }

  /* The style for the demo-area. */
  style demo-area {
    background: linear-gradient(45deg, #{actualTheme.contentFaded.color} 25%, transparent 25%, transparent 75%, #{actualTheme.contentFaded.color} 75%, #{actualTheme.contentFaded.color}),
                linear-gradient(45deg, #{actualTheme.contentFaded.color} 25%, transparent 25%, transparent 75%, #{actualTheme.contentFaded.color} 75%, #{actualTheme.contentFaded.color});

    background-color: #{actualTheme.content.color};
    background-position: 0 0, 0.625em 0.625em;
    background-size: 1.25em 1.25em;

    border-radius: 0.25em 0.25em 0 0;
    overflow: hidden;
    padding: 2em;

    if (fill) {
      display: grid;
    } else {
      justify-content: center;
      align-items: center;
      display: flex;
    }
  }

  /* The style for the demo-area wrapper. */
  style demo-area-wrapper {
    if (horizontalSpacing > 0 && !mobile) {
      grid-gap: #{horizontalSpacing}px;
      grid-auto-flow: column;
      align-items: center;
    }

    if (mobile) {
      grid-gap: #{horizontalSpacing}px;
    }

    if (verticalSpacing > 0) {
      grid-gap: #{verticalSpacing}px;
    }

    display: grid;
  }

  /* The style for the code. */
  style pre {
    background: #{actualTheme.contentFaded.color};
    border-top: 1px solid #{actualTheme.border};
    color: #{actualTheme.contentFaded.text};
    padding: 1em 1.25em;
    overflow: auto;
    margin: 0;

    if (mobile) {
      grid-column: 1;
    } else {
      grid-column: span 2;
    }

    code {
      all: unset;

      font-family: monospace;
      line-height: 150%;
      font-size: 1em;
    }
  }

  /* The style for the controls. */
  style controls {
    background: #{actualTheme.contentFaded.color};
    color: #{actualTheme.contentFaded.text};
    padding: 1em;

    align-content: start;
    align-items: start;
    grid-gap: 1em;
    display: grid;

    if (mobile) {
      border-top: 0.0625em solid #{actualTheme.border};
      min-width: 0;
    } else {
      border-left: 0.0625em solid #{actualTheme.border};
      min-width: 18.75em;
    }
  }

  /* Renders the component. */
  fun render : Html {
    try {
      controlsHtml =
        controls()

      {content, code} =
        data

      <div::base as base>
        <div::demo-area>
          <div::demo-area-wrapper>
            <{ content }>
          </div>
        </div>

        if (Html.Extra.isNotEmpty(controlsHtml)) {
          <div::controls>
            <{ controlsHtml }>
          </div>
        }

        <pre::pre>
          <code>
            <{ code }>
          </code>
        </pre>
      </div>
    }
  }
}
