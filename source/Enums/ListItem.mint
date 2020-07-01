enum Ui.ListItem {
  Divider

  Item(
  matchString : String,
    content : Html,
    key : String)
}

module Ui.ListItem {
  fun content (item : Ui.ListItem) : Html {
    case (item) {
      Ui.ListItem::Item content => content
      Ui.ListItem::Divider => <></>
    }
  }

  fun key (item : Ui.ListItem) : String {
    case (item) {
      Ui.ListItem::Item key => key
      Ui.ListItem::Divider => ""
    }
  }
}
