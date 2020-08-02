/* An auto complete component using the native `datalist` element. */
component Ui.Native.AutoComplete {
  connect Ui exposing { resolveTheme }

  /* The change event handler. */
  property onChange : Function(String, Promise(Never, Void)) = Promise.Extra.never1

  /* The options of the input. */
  property options : Array(String) = []

  /* The id of the datalist. */
  property id : String = Uid.generate()

  /* The placeholder to show when there is no value. */
  property placeholder : String = ""

  /* Wether or not the input is disabled. */
  property disabled : Bool = false

  /* Wether or not the input is invalid. */
  property invalid : Bool = false

  /* The currently selected value. */
  property value : String = ""

  /* The size of the input. */
  property size : Number = 16

  /* Renders the component. */
  fun render : Html {
    <>
      <Ui.Input
        placeholder={placeholder}
        disabled={disabled}
        onChange={onChange}
        invalid={invalid}
        value={value}
        size={size}
        list={id}/>

      <datalist id={id}>
        for (option of options) {
          <option value={option}/>
        }
      </datalist>
    </>
  }
}
