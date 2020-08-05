/*
An action sheet comes up from the bottom of the screen and displays actions
a user can take.

- usually this component is used in mobile resolutions
- showing the component returns a promise which is resolved when the
  component is closed
*/
global component Ui.ActionSheet {
  connect Ui exposing { mobile }

  /* The resolve function. */
  state resolve : Function(Void, Void) = (value : Void) { void }

  /* The displayed items. */
  state items : Array(Ui.NavItem) = []

  /* The state of the component (open / closed). */
  state open : Bool = false

  /* The base size of the component. */
  state size : Number = 16

  /* The theme for the action sheet. */
  state theme : Ui.Theme = Ui:DEFAULT_THEME

  /* The previously focused element. */
  state focusedElement : Maybe(Dom.Element) = Maybe::Nothing

  use Provider.Shortcuts {
    shortcuts =
      [
        {
          condition = () : Bool { true },
          bypassFocused = true,
          shortcut = [27],
          action = hide
        }
      ]
  }

  /* The style of the backdrop element. */
  style base {
    background: linear-gradient(rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.8));
    position: fixed;
    z-index: 1000;
    bottom: 0;
    right: 0;
    left: 0;
    top: 0;

    justify-content: flex-end;
    flex-direction: column;
    display: flex;

    font-size: #{size}px;

    if (!mobile) {
      align-items: center;
    }

    if (open) {
      transition: visibility 1ms, opacity 320ms;
      visibility: visibilie;
      opacity: 1;
    } else {
      transition: visibility 320ms 1ms, opacity 320ms;
      visibility: hidden;
      opacity: 0;
    }
  }

  /* Style of an item. */
  style item (group : Bool) {
    box-sizing: border-box;
    font-family: inherit;
    font-size: inherit;
    color: inherit;
    width: 100%;
    outline: 0;
    margin: 0;
    border: 0;

    grid-auto-flow: column;
    justify-content: start;
    align-items: center;
    grid-gap: 0.75em;
    display: grid;

    padding: 0 1em;
    height: 3em;

    &:first-child {
      border-radius: calc(1.5625em * var(--border-radius-coefficient))
                     calc(1.5625em * var(--border-radius-coefficient))
                     0 0;
    }

    &:last-child {
      border-radius: 0 0
                     calc(1.5625em * var(--border-radius-coefficient))
                     calc(1.5625em * var(--border-radius-coefficient));
    }

    if (group) {
      background: var(--content-faded-color);
      font-weight: bold;
    } else {
      cursor: pointer;
    }

    &:hover,
    &:focus {
      if (!group) {
        color: var(--primary-s500-color);
      }
    }
  }

  /* Style for the divider. */
  style divider {
    border-top: 0.1875em solid var(--border);
  }

  /* Style for the items container. */
  style items {
    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    transition: transform 320ms, opacity 320ms;
    margin: 0.625em;

    background: var(--content-color);
    color: var(--content-text);

    font-family: var(--font-family);

    > * + * {
      border-top: 0.0625em solid var(--border);
    }

    if (!mobile) {
      min-width: 300px;
    }

    if (open) {
      transform: translateY(0);
      opacity: 1;
    } else {
      transform: translateY(100%);
      opacity: 0;
    }
  }

  style group {
    grid-template-columns: 0.4375em 1fr;
    display: grid;
  }

  style gutter {
    border-right: 0.0625em solid var(--border);
    background: var(--content-faded-color);
  }

  style group-items {
    > * + * {
      border-top: 0.0625em solid var(--border);
    }
  }

  /* Hides the component. */
  fun hide : Promise(Never, Void) {
    sequence {
      next { open = false }

      Timer.timeout(320, "")
      resolve(void)
      Dom.focus(focusedElement)

      next
        {
          resolve = (value : Void) { void },
          focusedElement = Maybe::Nothing,
          items = [],
          theme = Ui:DEFAULT_THEME,
          size = 16
        }
    }
  }

  /* Shows the component with the given items and options. */
  fun showWithOptions (
    size : Number,
    theme : Ui.Theme,
    items : Array(Ui.NavItem)
  ) : Promise(Never, Void) {
    if (Array.isEmpty(items)) {
      next {  }
    } else {
      try {
        {resolve, reject, promise} =
          Promise.create()

        next
          {
            focusedElement = Dom.getActiveElement(),
            resolve = resolve,
            items = items,
            theme = theme,
            size = size,
            open = true
          }

        sequence {
          Timer.timeout(100, "")

          case (container) {
            Maybe::Just element => Dom.focusFirst(element)
            Maybe::Nothing => next {  }
          }
        }

        promise
      }
    }
  }

  /* Shows the component with the given items. */
  fun show (items : Array(Ui.NavItem)) : Promise(Never, Void) {
    showWithOptions(16, Ui:DEFAULT_THEME, items)
  }

  /* The close event handler. */
  fun handleClose (event : Html.Event) : Promise(Never, Void) {
    if (Dom.containsMaybe(container, event.target)) {
      next {  }
    } else {
      hide()
    }
  }

  /* The item click event handler. */
  fun handleItemClick (
    onClick : Function(Html.Event, Promise(Never, Void)),
    event : Html.Event
  ) {
    sequence {
      onClick(event)
      hide()
    }
  }

  /* The link click event handler. */
  fun handleLinkClick (href : String, event : Html.Event) {
    if (String.isNotEmpty(href)) {
      sequence {
        Window.navigate(href)
        hide()
      }
    } else {
      next {  }
    }
  }

  /* Renders the contents of the item. */
  fun renderContents (
    iconAfter : Html,
    iconBefore : Html,
    label : String,
    group : Bool,
    onClick : Function(Html.Event, Promise(Never, Void))
  ) {
    try {
      contents =
        <>
          if (Html.isNotEmpty(iconBefore)) {
            <Ui.Icon
              icon={iconBefore}
              autoSize={true}/>
          }

          <{ label }>

          if (Html.isNotEmpty(iconAfter)) {
            <Ui.Icon
              icon={iconAfter}
              autoSize={true}/>
          }
        </>

      if (group) {
        <div::item(group) onClick={onClick}>
          <{ contents }>
        </div>
      } else {
        <button::item(group) onClick={onClick}>
          <{ contents }>
        </button>
      }
    }
  }

  fun renderItem (item : Ui.NavItem) : Html {
    case (item) {
      Ui.NavItem::Item iconAfter iconBefore label action => renderContents(iconAfter, iconBefore, label, false, handleItemClick(action))
      Ui.NavItem::Link iconAfter iconBefore label href => renderContents(iconAfter, iconBefore, label, false, handleLinkClick(href))

      Ui.NavItem::Group iconAfter iconBefore label items =>
        <{
          renderContents(iconAfter, iconBefore, label, true, Promise.never1())

          <div::group>
            <div::gutter/>

            <div::group-items>
              for (item of items) {
                renderItem(item)
              }
            </div>
          </div>
        }>

      Ui.NavItem::Divider => <div::divider/>
    }
  }

  /* Renders the component. */
  fun render : Html {
    <Theme theme={theme}>
      <div::base onClick={handleClose}>
        <Ui.FocusTrap>
          <div::items as container>
            for (item of items) {
              renderItem(item)
            }
          </div>
        </Ui.FocusTrap>
      </div>
    </Theme>
  }
}
