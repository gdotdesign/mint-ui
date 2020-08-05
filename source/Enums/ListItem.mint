/* Represents an item in a list. */
enum Ui.ListItem {
  /* A divider between items. */
  Divider

  /*
  An item which consist of:
  - a key which should be unique
  - a content which is displayed
  - a match string which is searched against
  */
  Item(
    matchString : String,
    content : Html,
    key : String)
}

/* Utility functions for working with `Ui.ListItem`. */
module Ui.ListItem {
  /* Returns the `content` of a list item. */
  fun content (item : Ui.ListItem) : Html {
    case (item) {
      Ui.ListItem::Item content => content
      Ui.ListItem::Divider => <></>
    }
  }

  /* Returns the `matchString` of a list item. */
  fun matchString (item : Ui.ListItem) : String {
    case (item) {
      Ui.ListItem::Item matchString => matchString
      Ui.ListItem::Divider => ""
    }
  }

  /* Returns the `key` of a list item. */
  fun key (item : Ui.ListItem) : String {
    case (item) {
      Ui.ListItem::Item key => key
      Ui.ListItem::Divider => ""
    }
  }
}
