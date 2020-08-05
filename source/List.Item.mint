component Ui.List.Item {
  property children : Array(Html) = []

  property onClick : Function(Html.Event, Promise(Never, Void)) =
    (event : Html.Event) : Promise(Never, Void) { Promise.never() }

  property intended : Bool = false
  property selected : Bool = false
  property size : Number = 16

  style selected {
    background: var(--primary-s500-color);
    color: var(--primary-s500-text);

    &:hover {
      background: var(--primary-s700-color);
      color: var(--primary-s700-text);
    }
  }

  style normal {
    background: var(--content-color);
    color: var(--content-text);

    &:nth-child(odd) {
      background: var(--content-faded-color);
      color: var(--content-faded-text);
    }

    &:hover {
      background: var(--primary-s500-color);
      color: var(--primary-s500-text);
    }
  }

  style base {
    cursor: pointer;

    border-radius: calc(15px * var(--border-radius-coefficient));
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
