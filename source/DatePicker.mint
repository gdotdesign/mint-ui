/* A date picker component. */
component Ui.DatePicker {
  /* The change event handler. */
  property onChange : Function(Time, Promise(Never, Void)) = Promise.never1

  /* The size of the select. */
  property size : Number = 16

  /* The position of the dropdown. */
  property position : String = "bottom-right"

  /* The current value (as `Time`). */
  property value : Time = Time.today()

  /* Wether or not the select is invalid. */
  property invalid : Bool = false

  /* Wether or not the select is disabled. */
  property disabled : Bool = false

  /* The offset of the dropdown from the input. */
  property offset : Number = 5

  /* A variable for tracking the current month. */
  state month : Maybe(Time) = Maybe::Nothing

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    case (event.keyCode) {
      37 => onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() - 1)`)

      38 =>
        try {
          Html.Event.preventDefault(event)
          onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() - 1)`)
        }

      39 => onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() + 1)`)

      40 =>
        try {
          Html.Event.preventDefault(event)
          onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() + 1)`)
        }

      => next {  }
    }
  }

  /* Handles the month change event. */
  fun handleMonthChange (value : Time) {
    next { month = Maybe::Just(value) }
  }

  /* Renders the date picker. */
  fun render : Html {
    try {
      panel =
        <Ui.AvoidFocus disableCursor={false}>
          <Ui.Calendar as calendar
            month={Maybe.withDefault(value, month)}
            onMonthChange={handleMonthChange}
            onChange={onChange}
            embedded={true}
            day={value}
            size={size}/>
        </Ui.AvoidFocus>

      label =
        Maybe::Just(<{ Time.format("yyyy-MM-dd", value) }>)

      <Ui.Picker as picker
        icon={Ui.Icons:CHEVRON_DOWN}
        onKeyDown={handleKeyDown}
        matchWidth={false}
        disabled={disabled}
        invalid={invalid}
        position={position}
        offset={offset}
        panel={panel}
        label={label}
        size={size}/>
    }
  }
}
