record Ui.Tabs.Item {
  content : Function(Html),
  label : String,
  key : String
}

component Ui.Tabs.Tab {
  connect Ui exposing { theme }

  property onClick : Function(Promise(Never, Void)) = Promise.never
  property selected : Bool = false
  property label : String = ""

  style base {
    border-bottom: 2px solid {color};
    margin-bottom: -2px;
    padding: 20px 10px;
    cursor: pointer;
  }

  get color : String {
    if (selected) {
      theme.colors.primary.background
    } else {
      "transparent"
    }
  }

  fun render : Html {
    <div::base onClick={onClick}>
      <{ label }>
    </div>
  }
}

component Ui.Tabs {
  connect Ui exposing { theme }

  property onChange : Function(String, Promise(Never, Void)) =
    (key : String) : Promise(Never, Void) { next {  } }

  property items : Array(Ui.Tabs.Item) = []
  property disabled : Bool = false
  property selected : String = ""

  style base {

  }

  style tabs {
    border-bottom: 2px solid #EEE;
    font-family: {theme.fontFamily};
    display: flex;
  }

  style content {
    padding: 10px;
    padding-top: 20px;
  }

  fun handleSelect (key : String) : Promise(Never, Void) {
    if (key == selected) {
      next {  }
    } else {
      onChange(key)
    }
  }

  fun render : Html {
    <div::base>
      <div::tabs>
        for (tab of items) {
          <Ui.Tabs.Tab
            label={tab.label}
            selected={tab.key == selected}
            onClick={() : Promise(Never, Void) { handleSelect(tab.key) }}/>
        }
      </div>

      <div::content>
        <{
          items
          |> Array.find(
            (tab : Ui.Tabs.Item) : Bool { tab.key == selected })
          |> Maybe.map((tab : Ui.Tabs.Item) : Html { tab.content() })
          |> Maybe.withDefault(<></>)
        }>
      </div>
    </div>
  }
}
