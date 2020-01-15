module Promise.Extra {
  fun never1 (param : a) : Promise(Never, Void) {
    Promise.resolve(void)
  }

  fun never2 (param : a) : Promise(Never, Void) {
    Promise.resolve(void)
  }
}

module String.Extra {
  fun isNotEmpty (string : String) : Bool {
    !String.isEmpty(String.trim(string))
  }
}
