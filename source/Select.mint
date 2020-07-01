component Ui.Select {
  connect Ui exposing { resolveTheme }

  property onChange : Function(String, Promise(Never, Void)) =
    (selected : String) : Promise(Never, Void) { Promise.never() }

  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property items : Array(Ui.ListItem) = []
  property position : String = "bottom-right"
  property placeholder : String = ""
  property value : String = ""
  property invalid : Bool = false
  property disabled : Bool = false
  property size : Number = 16
  property offset : Number = 5
  property zIndex : Number = 1

  state focused : Bool = false
  state open : Bool = false

  use Provider.Keydown {
    keydowns = handleKeyDown
  } when {
    focused || open
  }

  use Providers.TabFocus {
    onTabIn =
      (item : Dom.Element) : Promise(Never, Void) {
        if (Maybe::Just(item) == element) {
          next
            {
              open = true,
              focused = true
            }
        } else {
          next {  }
        }
      },
    onTabOut =
      (item : Dom.Element) : Promise(Never, Void) {
        if (Maybe::Just(item) == element) {
          next
            {
              open = false,
              focused = false
            }
        } else {
          next {  }
        }
      }
  }

  get actualTheme {
    resolveTheme(theme)
  }

  style element {
    border-radius: #{size * actualTheme.borderRadiusCoefficient * 1.1875}px;
    border: #{size * 0.125}px solid #{actualTheme.border};
    background-color: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

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
      box-shadow: 0 0 0 #{size * 0.1875}px #{actualTheme.danger.shadow};
    } else if (open) {
      box-shadow: 0 0 0 #{size * 0.1875}px #{actualTheme.primary.shadow};
    }

    if (open && invalid) {
      border-color: #{actualTheme.danger.s300.color};
    } else if (invalid) {
      border-color: #{actualTheme.danger.s500.color};
    } else if (open || focused) {
      border-color: #{actualTheme.primary.s500.color};
    } else {
      border-color: #{actualTheme.border};
    }

    &:focus {
      if (invalid) {
        box-shadow: 0 0 0 0.1875em #{actualTheme.danger.shadow};
        border-color: #{actualTheme.danger.s300.color};
      } else {
        box-shadow: 0 0 0 0.1875em #{actualTheme.primary.shadow};
        border-color: #{actualTheme.primary.s500.color};
      }
    }
  }

  style placeholder {
    user-select: none;
    opacity: 0.5;
  }

  style grid {
    grid-template-columns: 1fr min-content;
    align-items: center;
    grid-gap: 0.625em;
    display: grid;
  }

  fun handleFocus : Promise(Never, Void) {
    sequence {
      next { focused = true }

      if (disabled) {
        next {  }
      } else if (open) {
        next { open = false }
      } else {
        sequence {
          Timer.nextFrame("")

          next { open = true }
        }
      }
    }
  }

  fun handleClose : Promise(Never, Void) {
    next { open = false }
  }

  fun handleKeyDown (event : Html.Event) {
    case (list) {
      Maybe::Just item =>
        case (event.keyCode) {
          27 => handleClose()

          13 =>
            sequence {
              item.handleKeyDown(event)

              if (open) {
                next {  }
              } else {
                next { open = true }
              }
            }

          => item.handleKeyDown(event)
        }

      Maybe::Nothing => next {  }
    }
  }

  fun handleSelect (value : String) : Promise(Never, Void) {
    sequence {
      onChange(value)
    }
  }

  fun render : Html {
    try {
      content =
        <Ui.Dropdown.Panel>
          <Ui.InteractiveList as list
            onSelect={handleSelect}
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
            name="chevron-down"
            autoSize={true}/>
        </div>

      html =
        if (disabled) {
          <div::element>
            <{ grid }>
          </div>
        } else {
          <div::element as element
            tabindex="0"
            onMouseUp={handleFocus}>

            <{ grid }>

          </div>
        }

      <Ui.Dropdown
        onClick={(event : Html.Event) { Dom.focus(element) }}
        closeOnOutsideClick={true}
        onClose={handleClose}
        position={position}
        offset={offset}
        open={open}
        content={content}
        element={html}/>
    }
  }
}
