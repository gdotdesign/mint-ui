/* A base component for implementing custom pickers (date, select). */
component Ui.Picker {
  connect Ui exposing { mobile }

  /* A handler for the keydown event if the picker is open or focused. */
  property onKeyDown : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* A handler for the enter event, if it returns true the picker is closed. */
  property onEnter : Function(Html.Event, Bool) = (event : Html.Event) { true }

  /* The label to display if there is a value. */
  property label : Maybe(Html) = Maybe::Nothing

  /* The content of the dropdown. */
  property panel : Html = <></>

  /* The icon to display at the right side of the label. */
  property icon : Html = <></>

  /* Wether or not the picker is invalid. */
  property invalid : Bool = false

  /* The placeholder to show when there is no value selected. */
  property placeholder : String = ""

  /* Wether or not the picker is disabled. */
  property disabled : Bool = false

  /* The position of the dropdown. */
  property position : String = "bottom-right"

  /* Wether or not the dropdown should match the width of the input. */
  property matchWidth : Bool = false

  /* The offset of the dropdown from the input. */
  property offset : Number = 5

  /* The size of the picker. */
  property size : Number = 16

  /* Wether or not the dropdown is shown. */
  state status : Ui.Picker.Status = Ui.Picker.Status::Idle

  use Providers.TabFocus {
    onTabOut = handleClose,
    onTabIn = handleTabIn,
    element = element
  }

  use Provider.OutsideClick {
    elements = [element, Maybe.flatten(dropdown&.base)],
    clicks = handleClicks
  } when {
    (status == Ui.Picker.Status::Focused ||
      status == Ui.Picker.Status::Open) && !mobile
  }

  use Provider.Keydown {
    keydowns = handleKeyDown
  } when {
    status == Ui.Picker.Status::Focused ||
      status == Ui.Picker.Status::Open
  }

  /* Handles the up events. */
  fun handleClicks : Promise(Never, Void) {
    next { status = Ui.Picker.Status::Idle }
  }

  /* Handler for the tab in event. */
  fun handleTabIn : Promise(Never, Void) {
    next { status = Ui.Picker.Status::Focused }
  }

  /* Handler for the close event. */
  fun handleClose : Promise(Never, Void) {
    next { status = Ui.Picker.Status::Idle }
  }

  /* Hides the dropdown. */
  fun hideDropdown : Promise(Never, Void) {
    next { status = Ui.Picker.Status::Focused }
  }

  /* Shows the dropdown. */
  fun showDropdown : Promise(Never, Void) {
    next { status = Ui.Picker.Status::Open }
  }

  /* Handler for the focus event (shows the dropdown). */
  fun handleFocus (event : Html.Event) : Promise(Never, Void) {
    sequence {
      next { status = Ui.Picker.Status::Focused }

      sequence {
        Timer.nextFrame("")

        next { status = Ui.Picker.Status::Open }
      }
    }
  }

  /*
  Handles the keydown event:
  - on ESCAPE key it hides the dropdown
  - on ENTER key it hides the dropdown if the handler returns tro
  - on SPACE key it shows the dropdown
  */
  fun handleKeyDown (event : Html.Event) {
    case (event.keyCode) {
      Html.Event:ESCAPE =>
        hideDropdown()

      Html.Event:ENTER =>
        if (onEnter(event)) {
          hideDropdown()
        } else {
          next {  }
        }

      Html.Event:SPACE =>
        try {
          Html.Event.preventDefault(event)
          showDropdown()
        }

      => onKeyDown(event)
    }
  }

  /* Returns if the picker is open. */
  get open : Bool {
    status == Ui.Picker.Status::Open
  }

  /* Returns if the picker is focued. */
  get focused : Bool {
    status == Ui.Picker.Status::Focused ||
      status == Ui.Picker.Status::Open
  }

  /* The styles for the element. */
  style element {
    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    border: #{size * 0.125}px solid var(--border);
    background-color: var(--content-color);
    color: var(--content-text);
    padding: 0.4375em 0.625em;
    height: 2.375em;

    font-family: sans-serif;
    font-size: #{size}px;
    line-height: 1.25em;

    box-sizing: border-box;
    position: relative;
    user-select: none;
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

  /* Renders the component. */
  fun render : Html {
    try {
      content =
        <Ui.Dropdown.Panel as dropdown size={size}>
          <{ panel }>
        </Ui.Dropdown.Panel>

      grid =
        <div::grid>
          <{
            Maybe.withDefault(
              <div::placeholder>
                <{ placeholder }>
              </div>,
              label)
          }>

          if (Html.isNotEmpty(icon)) {
            <Ui.Icon
              icon={icon}
              autoSize={true}/>
          } else {
            <div/>
          }
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

      /*
      The onClick handler is needed to focus the element when clicking
      into the dropdown so it not loses focus.
      */
      <Ui.Dropdown
        onClick={(event : Html.Event) { Dom.focus(element) }}
        onClose={handleClose}
        closeOnOutsideClick={true}
        matchWidth={matchWidth}
        position={position}
        content={content}
        offset={offset}
        element={html}
        open={open}/>
    }
  }
}
