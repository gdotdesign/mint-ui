/*
Represents a navigation item, it is used in certain components:
- Ui.ActionSheet
- Ui.Header
*/
enum Ui.NavItem {
  /* A divider. */
  Divider

  /* An item which has an action. */
  Item(
    action : Function(Html.Event, Promise(Never, Void)),
    iconBefore : Html,
    iconAfter : Html,
    label : String)

  /* An item which links to a different page. */
  Link(
    iconBefore : Html,
    iconAfter : Html,
    label : String,
    href : String)
}
