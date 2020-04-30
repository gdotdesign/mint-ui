record SelectableList {
  original : Array(String),
  selected : Set(String),
  items : Array(String),
  intended : String
}

module SelectableList {
  fun intendAt (index : Number, list : SelectableList) : SelectableList {
    try {
      nextIntended =
        list.items
        |> Array.at(index)
        |> Maybe.withDefault("")

      { list | intended = nextIntended }
    }
  }

  /* Sets the next intended item in the list. */
  fun intendNext (list : SelectableList) : SelectableList {
    try {
      index =
        Array.indexOf(list.intended, list.items)

      nextIndex =
        if (index == 0) {
          Array.size(list.items) - 1
        } else {
          index - 1
        }

      intendAt(nextIndex, list)
    }
  }

  /* Sets the previous intended item in the list. */
  fun intendPrevious (list : SelectableList) : SelectableList {
    try {
      index =
        Array.indexOf(list.intended, list.items)

      nextIndex =
        if (index == Array.size(list.items) - 1) {
          0
        } else {
          index + 1
        }

      nextIntended =
        list.items
        |> Array.at(nextIndex)
        |> Maybe.withDefault("")

      intendAt(nextIndex, list)
    }
  }

  /* Filters the list by the given search input. */
  fun filter (search : String, list : SelectableList) : SelectableList {
    try {
      regexp =
        Regexp.createWithOptions(
          search,
          {
            caseInsensitive = true,
            multiline = false,
            unicode = false,
            global = false,
            sticky = false
          })

      items =
        list.original
        |> Array.select((item : String) { Regexp.match(item, regexp) })

      intendAt(0, { list | items = items })
    }
  }
}
