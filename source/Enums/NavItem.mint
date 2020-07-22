/*
Represents a navigation item, it is used in certain components:
- Ui.ActionSheet
- Ui.Header
*/
enum Ui.NavItem {
  /* A divider. */
  Divider

  /* A group of other navigation items. */
  Group(
    items : Array(Ui.NavItem),
    iconBefore : Html,
    iconAfter : Html,
    label : String,
    key : String)

  /* An item which has an action. */
  Item(
    action : Function(Html.Event, Promise(Never, Void)),
    iconBefore : Html,
    iconAfter : Html,
    label : String,
    key : String)

  /* An item which links to a different page. */
  Link(
    iconBefore : Html,
    iconAfter : Html,
    label : String,
    href : String,
    key : String)
}
