/*
An action sheet comes up from the bottom of the screen and displays actions
a user can take.

- usually this component is used in mobile resolutions
- showing the component returns a promise which is resolved when the
  component is closed
*/
global component Ui.ActionSheet {
  connect Ui exposing { resolveTheme, mobile }

  /* The resolve function. */
  state resolve : Function(Void, Void) = (value : Void) { void }

  /* The theme for the component. */
  state theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The displayed items. */
  state items : Array(Ui.NavItem) = []

  /* The state of the component (open / closed). */
  state open : Bool = false

  /* The base size of the component. */
  state size : Number = 16

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
  style item {
    grid-auto-flow: column;
    justify-content: start;
    align-items: center;
    grid-gap: 0.75em;
    display: grid;

    padding: 0 1em;
    height: 3em;

    + * {
      border-top: 0.0625em solid #{actualTheme.border};
    }

    &:hover {
      color: #{actualTheme.primary.s500.color};
    }
  }

  /* Style for the divider. */
  style divider {
    border-top: 0.1875em solid #{actualTheme.border};
  }

  /* Style for the items container. */
  style items {
    border-radius: #{1.5625 * actualTheme.borderRadiusCoefficient}em;
    transition: transform 320ms, opacity 320ms;
    margin: 0.625em;

    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    font-family: #{actualTheme.fontFamily};
    cursor: pointer;

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

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Hides the component. */
  fun hide : Promise(Never, Void) {
    sequence {
      next { open = false }

      Timer.timeout(320, "")
      resolve(void)

      next { resolve = (value : Void) { void } }
    }
  }

  /* Shows the component with the given items and options. */
  fun showWithOptions (
    theme : Maybe(Ui.Theme),
    size : Number,
    items : Array(Ui.NavItem)
  ) : Promise(Never, Void) {
    if (Array.isEmpty(items)) {
      next {  }
    } else {
      try {
        {resolve, reject, promise} =
          Promise.Extra.create()

        next
          {
            resolve = resolve,
            theme = theme,
            items = items,
            size = size,
            open = true
          }

        promise
      }
    }
  }

  /* Shows the component with the given items. */
  fun show (items : Array(Ui.NavItem)) : Promise(Never, Void) {
    showWithOptions(Maybe::Nothing, 16, items)
  }

  /* The close event handler. */
  fun handleClose (event : Html.Event) : Promise(Never, Void) {
    if (Dom.Extra.containsMaybe(container, event.target)) {
      next {  }
    } else {
      hide()
    }
  }

  /* The click event handler. */
  fun handleClick (href : String, event : Html.Event) {
    if (String.Extra.isNotEmpty(href)) {
      sequence {
        Window.navigate(href)
        hide()
      }
    } else {
      next {  }
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base onClick={handleClose}>
      <div::items as container>
        for (item of items) {
          case (item) {
            Ui.NavItem::Divider => <div::divider/>

            Ui.NavItem::Item iconAfter iconBefore label href =>
              <div::item onClick={handleClick(href)}>
                if (String.Extra.isNotEmpty(iconBefore)) {
                  <Ui.Icon
                    name={iconBefore}
                    autoSize={true}/>
                }

                <{ label }>

                if (String.Extra.isNotEmpty(iconAfter)) {
                  <Ui.Icon
                    name={iconAfter}
                    autoSize={true}/>
                }
              </div>
          }
        }
      </div>
    </div>
  }
}
