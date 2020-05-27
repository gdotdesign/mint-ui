global component Ui.ActionSheet {
  connect Ui exposing { borderColor, contentBackground, contentText, fontFamily, primaryBackground }

  state items : Array(Ui.Items) = []
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
    grid-gap: 10px;
    align-items: center;
    display: grid;

    padding: 0 15px;
    height: 50px;

    + * {
      border-top: 1px solid #{borderColor};
    }

    &:hover {
      color: #{primaryBackground};
    }
  }

  style label {
    line-height: 16px;
    height: 16px;
  }

  style divider {
    border-top: 3px solid #{borderColor};
  }

  style items {
    border-radius: 3px;
    transition: 320ms;
    margin: 10px;

    background: #{contentBackground};
    color: #{contentText};

    font-family: #{fontFamily};
    cursor: pointer;

    if (open) {
      transform: translateY(0);
      opacity: 1;
    } else {
      transform: translateY(100%);
      opacity: 0;
    }
  }

  fun hide : Promise(Never, Void) {
    next { open = false }
  }

  fun show (items : Array(Ui.Items)) : Promise(Never, Void) {
    if (Array.isEmpty(items)) {
      next {  }
    } else {
      next
        {
          items = items,
          open = true
        }
    }
  }

  fun handleClose (event : Html.Event) : Promise(Never, Void) {
    if (Dom.contains(
        event.target,
        Maybe.withDefault(Dom.createElement("div"), container))) {
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
                <Ui.Icon
                  name={item.iconBefore}
                  autoSize={true}/>

                <div::label>
                  <{ item.label }>
                </div>
              </div>
          }
        }
      </div>
    </div>
  }
}
