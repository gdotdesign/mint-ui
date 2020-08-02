/* Represents a table cell. */
enum Ui.Cell {
  Actions(Array(Tuple(Html, Bool, Function(Html.Event, Promise(Never, Void)))))
  String(String)
  Number(Number)
  Code(String)
  Html(Html)
}
