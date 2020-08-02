/* Component for rendering a `Ui.Cell` enum. */
component Ui.Cell {
  connect Ui exposing { resolveTheme }

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The size of the cell. */
  property size : Number = 16

  /* The cell itself. */
  property cell : Ui.Cell

  /* Styles for the base. */
  style base {
    font-size: #{size}px;
  }

  /* Styles for the code. */
  style code {
    background: #{actualTheme.contentFaded.color};
    border: 0.0625em solid #{actualTheme.border};
    color: #{actualTheme.contentFaded.text};

    padding: 0.125em 0.375em 0px;
    border-radius: 0.125em;
    font-size: 0.875em;
    white-space: pre;
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the cell. */
  fun render : Html {
    <div::base>
      case (cell) {
        Ui.Cell::Number value => <{ Number.toString(value) }>
        Ui.Cell::String value => <{ value }>
        Ui.Cell::Html value => value

        Ui.Cell::Code value =>
          <code::code>
            <{ value }>
          </code>

        Ui.Cell::Actions actions =>
          <Ui.LineGrid>
            for (item of actions) {
              try {
                {icon, disabled, action} =
                  item

                <Ui.Icon
                  disabled={disabled}
                  interactive={true}
                  onClick={action}
                  icon={icon}/>
              }
            }
          </Ui.LineGrid>
      }
    </div>
  }
}
