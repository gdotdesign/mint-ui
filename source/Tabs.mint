/* A simple tabs component. */
component Ui.Tabs {
  /* The change event handler. */
  property onChange : Function(String, Promise(Never, Void)) = Promise.never1

  /* The data for the tabs. */
  property items : Array(Ui.Tab) = []

  /* The `key` for the active tab. */
  property active : String = ""

  /* The size of the component. */
  property size : Number = 16

  /* The style for the base element. */
  style base {
    background: var(--content-color);
    color: var(--content-text);

    font-family: var(--font-family);
    font-size: #{size}px;

    grid-template-rows: min-content 1fr;
    display: grid;
  }

  /* The style for the tab handles container. */
  style tabs {
    border-bottom: 0.1875em solid var(--content-faded-color);
    grid-auto-flow: column;
    grid-gap: 0.5em;
    display: grid;
  }

  /* The style for the content. */
  style content {
    padding: 1em;
  }

  /* The style for a specific tab handle. */
  style tab (active : Bool) {
    background: 0;
    border: 0;

    margin-bottom: -0.1875em;
    padding: 1.2em 1em;

    font-size: inherit;
    font-weight: bold;

    grid-auto-flow: column;
    align-items: center;
    grid-gap: 1em;
    display: grid;

    white-space: nowrap;
    cursor: pointer;
    outline: none;

    &:focus {
      border-bottom: 0.1875em solid var(--primary-s300-color);
      color: var(--primary-s300-color);
    }

    if (active) {
      border-bottom: 0.1875em solid var(--primary-s500-color);
      color: var(--primary-s500-color);
    } else {
      border-bottom: 0.1875em solid transparent;
    }
  }

  /* The event handler for the tab select. */
  fun handleSelect (key : String) : Promise(Never, Void) {
    if (key == active) {
      next {  }
    } else {
      onChange(key)
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::tabs>
        for (tab of items) {
          <button::tab(tab.key == active) onClick={() { handleSelect(tab.key) }}>
            if (Html.isNotEmpty(tab.iconBefore)) {
              <Ui.Icon
                icon={tab.iconBefore}
                autoSize={true}/>
            }

            <{ tab.label }>

            if (Html.isNotEmpty(tab.iconAfter)) {
              <Ui.Icon
                icon={tab.iconAfter}
                autoSize={true}/>
            }
          </button>
        }
      </div>

      <div::content>
        <{
          items
          |> Array.find((tab : Ui.Tab) { tab.key == active })
          |> Maybe.map((tab : Ui.Tab) { tab.content })
          |> Maybe.withDefault(<></>)
        }>
      </div>
    </div>
  }
}
