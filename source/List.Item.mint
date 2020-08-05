component Ui.List.Item {
  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* The content to render. */
  property children : Array(Html) = []

  /* Wether or not the item is inteded. */
  property intended : Bool = false

  /* Wether or not the item is slected. */
  property selected : Bool = false

  /* The size of the item. */
  property size : Number = 16

  /* Styles for the selected item. */
  style selected {
    background: var(--primary-s500-color);
    color: var(--primary-s500-text);

    &:hover {
      background: var(--primary-s700-color);
      color: var(--primary-s700-text);
    }
  }

  /* Styles for the normal item. */
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

  /* Styles for the base. */
  style base {
    border-radius: calc(15px * var(--border-radius-coefficient));
    font-size: #{size}px;
    user-select: none;
    padding: 0.625em;
    cursor: pointer;

    grid-gap: 0.3125em 0.625em;
    align-items: center;
    display: grid;
  }

  /* Renders the item. */
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
