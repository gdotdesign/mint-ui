global component Ui.ActionSheet {
  connect Ui exposing { resolveTheme }

  state theme : Maybe(Ui.Theme) = Maybe::Nothing
  state items : Array(Ui.Items) = []
  state size : Number = 16

  state resolve : Function(Void, Void) = (value : Void) { void }
  state open : Bool = false

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

    backdrop-filter: blur(5px);
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

  style label {
    line-height: 1em;
    height: 1em;
  }

  style divider {
    border-top: 0.1875em solid #{actualTheme.border};
  }

  style items {
    border-radius: #{size * actualTheme.borderRadiusCoefficient * 1.1875}px;
    transition: 320ms;
    margin: 0.625em;

    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    font-family: #{actualTheme.fontFamily};
    cursor: pointer;

    if (open) {
      transform: translateY(0);
      opacity: 1;
    } else {
      transform: translateY(100%);
      opacity: 0;
    }
  }

  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  fun setTheme (theme : Maybe(Ui.Theme)) : Promise(Never, Void) {
    next { theme = theme }
  }

  fun setSize (size : Number) : Promise(Never, Void) {
    next { size = size }
  }

  fun hide : Promise(Never, Void) {
    try {
      resolve(void)

      next
        {
          resolve = (value : Void) { void },
          open = false
        }
    }
  }

  fun show (items : Array(Ui.Items)) : Promise(Never, Void) {
    if (Array.isEmpty(items)) {
      next {  }
    } else {
      try {
        {resolve, reject, promise} =
          Promise.Extra.create()

        next
          {
            resolve = resolve,
            items = items,
            open = true
          }

        promise
      }
    }
  }

  fun handleClose (event : Html.Event) : Promise(Never, Void) {
    if (Dom.Extra.containsMaybe(container, event.target)) {
      next {  }
    } else {
      hide()
    }
  }

  fun handleClick (item : Ui.Item, event : Html.Event) {
    if (String.Extra.isNotEmpty(item.href)) {
      sequence {
        Window.navigate(item.href)
        hide()
      }
    } else {
      next {  }
    }
  }

  fun render : Html {
    <div::base onClick={handleClose}>
      <div::items as container>
        for (item of items) {
          case (item) {
            Ui.Items::Divider => <div::divider/>

            Ui.Items::Item item =>
              <div::item onClick={handleClick(item)}>
                if (String.Extra.isNotEmpty(item.iconBefore)) {
                  <Ui.Icon
                    name={item.iconBefore}
                    autoSize={true}/>
                }

                <{ item.label }>

                if (String.Extra.isNotEmpty(item.iconAfter)) {
                  <Ui.Icon
                    name={item.iconAfter}
                    autoSize={true}/>
                }
              </div>
          }
        }
      </div>
    </div>
  }
}
