module Validation {
  fun isBlank (value : String, error : Tuple(String, String)) : Maybe(Tuple(String, String)) {
    if (String.Extra.isNotEmpty(value)) {
      Maybe::Nothing
    } else {
      Maybe::Just(error)
    }
  }

  fun isNumber (value : String, error : Tuple(String, String)) : Maybe(Tuple(String, String)) {
    case (Number.fromString(value)) {
      Maybe::Just => Maybe::Nothing
      => Maybe::Just(error)
    }
  }

  fun exactNumberOfCharacters (
    value : String,
    size : Number,
    error : Tuple(String, String)
  ) : Maybe(Tuple(String, String)) {
    if (String.size(value) == size) {
      Maybe::Nothing
    } else {
      Maybe::Just(error)
    }
  }

  fun hasNumberOfCharacters (
    value : String,
    size : Number,
    error : Tuple(String, String)
  ) : Maybe(Tuple(String, String)) {
    if (String.size(value) >= size) {
      Maybe::Nothing
    } else {
      Maybe::Just(error)
    }
  }

  fun isInvalidEmail (value : String, error : Tuple(String, String)) : Maybe(Tuple(String, String)) {
    try {
      regexpString =
        "^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

      valid =
        Regexp.createWithOptions(
          regexpString,
          {
            caseInsensitive = true,
            multiline = false,
            unicode = false,
            global = false,
            sticky = false
          })
        |> Regexp.match(value)

      if (valid) {
        Maybe::Nothing
      } else {
        Maybe::Just(error)
      }
    }
  }

  fun merge (errors : Array(Maybe(Tuple(String, String)))) : Map(String, String) {
    errors
    |> Array.reduce(
      Map.empty(),
      (
        memo : Map(String, String),
        item : Maybe(Tuple(String, String))
      ) : Map(String, String) {
        case (item) {
          Maybe::Just error =>
            try {
              {key, message} =
                error

              if (Map.has(key, memo)) {
                memo
              } else {
                Map.set(key, message, memo)
              }
            }

          => memo
        }
      })
  }
}
