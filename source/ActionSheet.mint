/*
An action sheet comes up from the bottom of the screen and displays actions
a user can take.

- usually this component is used in mobile resolutions
- showing the component returns a promise which is resolved when closed
- the keyboard focus is trapped in the list (tab and shift-tab)
- when closed the focus is returned to the last focused element before opening
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
    background: linear-gradient(rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.8));
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

  /* Style for the scroll container. */
  style container {
    transition: transform 320ms, opacity 320ms;
    overscroll-behavior: contain;
    scrollbar-width: thin;
    text-align: center;
    overflow: auto;
    min-height: 0;

    if (open) {
      transform: translateY(0);
      opacity: 1;
    } else {
      transform: translateY(100%);
      opacity: 0;
    }
  }

  /* Style for the items container. */
  style items {
    border-radius: calc(1.5625em * var(--border-radius-coefficient));
    overflow: hidden;
    margin: 0.625em;

    background: var(--content-color);
    font-family: var(--font-family);
    color: var(--content-text);
    text-align: left;

    > * + * {
      border-top: 0.0625em solid var(--border);
    }

    if (mobile) {
      display: block;
    } else {
      display: inline-block;
      min-width: 300px;
    }
  }

  /* Styles for a group of items. */
  style group {
    grid-template-columns: 0.4375em 1fr;
    display: grid;
  }

  /* Styles for the gutter on the left. */
  style gutter {
    border-right: 0.0625em solid var(--border);
    background: var(--content-faded-color);
  }

  /* Styles for the group item container. */
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
          theme = Ui:DEFAULT_THEME,
          items = [],
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

          case (scrollContainer) {
            Maybe::Just element => Dom.scrollTo(element, 0, 0)
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

  /* Renders the given navigation item. */
  fun renderItem (item : Ui.NavItem) : Html {
    case (item) {
      Ui.NavItem::Divider => <div::divider/>

      Ui.NavItem::Item iconAfter iconBefore label action =>
        renderContents(
          iconAfter,
          iconBefore,
          label,
          false,
          handleItemClick(action))

      Ui.NavItem::Link iconAfter iconBefore label href =>
        renderContents(
          iconAfter,
          iconBefore,
          label,
          false,
          handleLinkClick(href))

      Ui.NavItem::Group iconAfter iconBefore label items =>
        <>
          <{
            renderContents(
              iconAfter,
              iconBefore,
              label,
              true,
              Promise.never1())
          }>

          <div::group>
            <div::gutter/>

            <div::group-items>
              for (item of items) {
                renderItem(item)
              }
            </div>
          </div>
        </>
    }
  }

  /* Renders the component. */
  fun render : Html {
    <Ui.Theme theme={theme}>
      <Ui.FocusTrap>
        <div::base onClick={handleClose}>
          <div::container as scrollContainer>
            <div::items as container>
              for (item of items) {
                renderItem(item)
              }
            </div>
          </div>
        </div>
      </Ui.FocusTrap>
    </Ui.Theme>
  }
}
