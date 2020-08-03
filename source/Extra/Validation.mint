/*
A module for providing validations for values (mostly used in forms).

A validation function gets the parameters and an error to return if the
validation fails.

The error is a `Tuple(String, String)` where the first parameter is the key of
the field and the second is the error message.

The result of the validation is a `Maybe(error)`. If it's `Maybe::Nothing` then
there validation succeeded, otherwise it will be a `Maybe::Just(error)` meaning
the validation failed.

Here is an example of doing validation for a checkout form:

  errors =
    Validation.merge(
      [
        Validation.isBlank(firstName, {"firstName", "Plase enter the first name."}),
        Validation.isBlank(message, {"message", "Plase enter the message."}),
        Validation.isBlank(lastName, {"lastName", "Plase enter the last name."}),
        Validation.isBlank(phone, {"phone", "Plase enter the phone number."}),
        Validation.isBlank(email, {"email", "Plase enter the email address."}),
        Validation.isInvalidEmail(email, {"email", "Plase enter the a valid email address."}),
        Validation.isBlank(address, {"address", "Plase enter the address."}),
        Validation.isBlank(city, {"city", "Plase enter the city address."}),
        Validation.isBlank(country, {"country", "Plase select the country."}),
        Validation.isBlank(zip, {"zip", "Plase enter the zip code."}),
        Validation.isNumber(zip, {"zip", "The zip code can only contain numbers."}),
        Validation.exactNumberOfCharacters(zip, 5, {"zip", "The zip code needs to have 5 digits."})
      ])

Here the `errors` variable contains a `Map(String, Array(String))` where they key of
the field is the the key of the error and the value of the field is the error
messages for that key.

If the `errors` is empty that means that there are no errors.
*/
module Validation {
  /*
  Returns the given error when the given string is blank
  (contains only whitespace).

    Validation.isBlank("", {"name", "Name is empty!"}) ==
      Maybe::Just({"name", "Name is empty!"})
  */
  fun isBlank (value : String, error : Tuple(String, String)) : Maybe(Tuple(String, String)) {
    if (String.isNotEmpty(value)) {
      Maybe::Nothing
    } else {
      Maybe::Just(error)
    }
  }

  /*
  Returns the given error if the given string is not a number.

    Validation.isNumber("asd", {"age", "Age is not a number!"}) ==
      Maybe::Just({"age", "Age is not a number!"})
  */
  fun isNumber (value : String, error : Tuple(String, String)) : Maybe(Tuple(String, String)) {
    case (Number.fromString(value)) {
      Maybe::Just => Maybe::Nothing
      => Maybe::Just(error)
    }
  }

  /*
  Returns the given error if the two given values are not the same.

    Validation.isSame(
      "password",
      "confirmation",
      {"confirmation", "Confirmation is not the same!"}) ==
        Maybe::Just({"confirmation", "Confirmation is not the same!"})
  */
  fun isSame (value : a, value2 : a, error : Tuple(String, String)) : Maybe(Tuple(String, String)) {
    if (value == value2) {
      Maybe::Nothing
    } else {
      Maybe::Just(error)
    }
  }

  /*
  Returns the given error if the given string is does not have the exact number
  of characters.


    Validation.exactNumberOfCharacters(
      "",
      5,
      {"zip", "Zip code does is not 5 characters!"}) ==
        Maybe::Just({"zip", "Zip code does is not 5 characters!"})
  */
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

  fun getFirstError (key : String, errors : Map(String, Array(String))) : Maybe(String) {
    errors
    |> Map.get(key)
    |> Maybe.map(Array.first)
    |> Maybe.flatten
  }

  fun merge (errors : Array(Maybe(Tuple(String, String)))) : Map(String, Array(String)) {
    errors
    |> Array.reduce(
      Map.empty(),
      (
        memo : Map(String, Array(String)),
        item : Maybe(Tuple(String, String))
      ) : Map(String, Array(String)) {
        case (item) {
          Maybe::Just error =>
            try {
              {key, message} =
                error

              messages =
                memo
                |> Map.get(key)
                |> Maybe.withDefault([])

              Map.set(key, Array.push(message, messages), memo)
            }

          => memo
        }
      })
  }
}
