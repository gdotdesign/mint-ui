/* A select component. */
component Ui.Select {
  connect Ui exposing { mobile }

  /* The change event handler. */
  property onChange : Function(String, Promise(Never, Void)) = Promise.never1

  /* The items to show. */
  property items : Array(Ui.ListItem) = []

  /* The placeholder to show when there is no value selected. */
  property placeholder : String = ""

  /* The key of the current selected element. */
  property value : String = ""

  /* Wether or not the select is invalid. */
  property invalid : Bool = false

  /* Wether or not the select is disabled. */
  property disabled : Bool = false

  /* The size of the select. */
  property size : Number = 16

  /* The position of the dropdown. */
  property position : String = "bottom-right"

  /* Wether or not the dropdown should match the width of the input. */
  property matchWidth : Bool = false

  /* The offset of the dropdown from the input. */
  property offset : Number = 5

  /* the z-index of the dropdown. */
  property zIndex : Number = 1

  /* A variable for tracking the focused state. */
  state focused : Bool = false

  /* A variable for tracking the open state. */
  state open : Bool = false

  use Provider.Keydown {
    keydowns = handleKeyDown
  } when {
    focused || open
  }

  use Providers.TabFocus {
    onTabOut = handleClose,
    onTabIn = handleTabIn,
    element = element
  }

  use Provider.OutsideClick {
    clicks = handleClicks,
    element = element
  } when {
    focused
  }

  /* The styles for the element. */
  style element {
    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    border: #{size * 0.125}px solid var(--border);
    background-color: var(--content-color);
    color: var(--content-text);

    font-family: sans-serif;
    box-sizing: border-box;
    user-select: none;

    line-height: 1.25em;
    font-size: #{size}px;

    height: 2.375em;

    padding: 0.5em 0.625em;

    position: relative;
    outline: none;

    if (disabled) {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    } else {
      cursor: pointer;
    }

    if (open && invalid) {
      box-shadow: 0 0 0 #{size * 0.1875}px var(--danger-shadow);
    } else if (open) {
      box-shadow: 0 0 0 #{size * 0.1875}px var(--primary-shadow);
    }

    if (open && invalid) {
      border-color: var(--danger-s300-color);
    } else if (invalid) {
      border-color: var(--danger-s500-color);
    } else if (open || focused) {
      border-color: var(--primary-s500-color);
    } else {
      border-color: var(--border);
    }

    &:focus {
      if (invalid) {
        box-shadow: 0 0 0 0.1875em var(--danger-shadow);
        border-color: var(--danger-s300-color);
      } else {
        box-shadow: 0 0 0 0.1875em var(--primary-shadow);
        border-color: var(--primary-s500-color);
      }
    }
  }

  /* The styles for the placeholder. */
  style placeholder {
    user-select: none;
    opacity: 0.5;
  }

  /* The styles for the grid. */
  style grid {
    grid-template-columns: 1fr min-content;
    align-items: center;
    grid-gap: 0.625em;
    display: grid;
  }

  /* Handler for the tab in event. */
  fun handleTabIn : Promise(Never, Void) {
    next { focused = true }
  }

  /* Handler for the focus event. */
  fun handleFocus : Promise(Never, Void) {
    sequence {
      next { focused = true }

      sequence {
        Timer.nextFrame("")

        next { open = true }
      }
    }
  }

  /* Handles the up events. */
  fun handleClicks : Promise(Never, Void) {
    next { focused = false }
  }

  /* Handler for the close event. */
  fun handleClose : Promise(Never, Void) {
    next
      {
        focused = false,
        open = false
      }
  }

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    case (list) {
      Maybe::Just item =>
        case (event.keyCode) {
          Html.Event:ESCAPE => next { open = false }

          Html.Event:ENTER =>
            sequence {
              item.handleKeyDown(event)

              next { open = false }
            }

          Html.Event:SPACE =>
            try {
              Html.Event.preventDefault(event)
              next { open = true }
            }

          => item.handleKeyDown(event)
        }

      Maybe::Nothing => next {  }
    }
  }

  fun handleClickSelect (value : String) : Promise(Never, Void) {
    sequence {
      onChange(value)
      next { open = false }
    }
  }

  fun render : Html {
    try {
      content =
        <Ui.Dropdown.Panel size={size}>
          <Ui.InteractiveList as list
            onClickSelect={handleClickSelect}
            onSelect={onChange}
            interactive={false}
            size={size}
            selected={
              Set.empty()
              |> Set.add(value)
            }
            items={items}/>
        </Ui.Dropdown.Panel>

      label =
        items
        |> Array.find(
          (item : Ui.ListItem) : Bool { Ui.ListItem.key(item) == value })
        |> Maybe.map(
          (item : Ui.ListItem) {
            <div>
              <{ Ui.ListItem.content(item) }>
            </div>
          })
        |> Maybe.withDefault(
          <div::placeholder>
            <{ placeholder }>
          </div>)

      grid =
        <div::grid>
          <{ label }>

          <Ui.Icon
            icon={Ui.Icons:CHEVRON_DOWN}
            autoSize={true}/>
        </div>

      html =
        if (disabled) {
          <div::element>
            <{ grid }>
          </div>
        } else {
          <div::element as element
            onMouseUp={handleFocus}
            tabindex="0">

            <{ grid }>

          </div>
        }

      <Ui.Dropdown
        onClick={(event : Html.Event) { Dom.focus(element) }}
        closeOnOutsideClick={true}
        matchWidth={matchWidth}
        onClose={handleClose}
        position={position}
        content={content}
        offset={offset}
        element={html}
        open={open}/>
    }
  }
}
