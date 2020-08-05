/* Represents a table cell. */
enum Ui.Cell {
  /* Actions that the user can take, usually done with icons. */
  Actions(Array(Html))

  /* A simple string value. */
  String(String)

  /* A simple number value. */
  Number(Number)

  /* A code. */
  Code(String)

  /* Abritrary HTML content. */
  Html(Html)
}
