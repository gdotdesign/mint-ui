component Ui.List {
  property children : Array(Html) = []

  style base {
    > * + * {
      margin-top: 5px;
    }
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}

component Ui.List.Item {
  connect Ui exposing { resolveTheme }

  property children : Array(Html) = []

  property onClick : Function(Html.Event, Promise(Never, Void)) =
    (event : Html.Event) : Promise(Never, Void) { Promise.never() }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property intended : Bool = false
  property selected : Bool = false
  property size : Number = 16

  get actualTheme {
    resolveTheme(theme)
  }

  style selected {
    background: #{actualTheme.primary.s500.color};
    color: #{actualTheme.primary.s500.text};

    &:hover {
      background: #{actualTheme.primary.s700.color};
      color: #{actualTheme.primary.s700.text};
    }
  }

  style normal {
    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    &:nth-child(odd) {
      background: #{actualTheme.contentFaded.color};
      color: #{actualTheme.contentFaded.text};
    }

    &:hover {
      background: #{actualTheme.primary.s500.color};
      color: #{actualTheme.primary.s500.text};
    }
  }

  style base {
    cursor: pointer;

    border-radius: #{15 * actualTheme.borderRadiusCoefficient}px;
    user-select: none;
    padding: 0.625em;

    align-items: center;
    grid-gap: 0.3125em 0.625em;
    font-size: #{size}px;
    display: grid;
  }

  fun render : Html {
    try {
      grid =
        <Ui.LineGrid gap={5}>
          if (intended) {
            <Ui.Icon icon={Ui.Icons:CHEVRON_RIGHT}/>
          }

          <{ children }>
        </Ui.LineGrid>

      if (selected) {
        <div::base::selected onClick={onClick}>
          <{ grid }>
        </div>
      } else {
        <div::base::normal onClick={onClick}>
          <{ grid }>
        </div>
      }
    }
  }
}
