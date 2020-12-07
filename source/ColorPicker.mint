/* A color picker component. */
component Ui.ColorPicker {
  /* The change event handler. */
  property onChange : Function(Color, Promise(Never, Void)) = Promise.never1

  /* The size of the picker. */
  property size : Number = 16

  /* The position of the dropdown. */
  property position : String = "bottom-right"

  /* The current value (as `Color`). */
  property value : Color = Color::HEX("000000FF")

  /* Wether or not the picker is invalid. */
  property invalid : Bool = false

  /* Wether or not the picker is disabled. */
  property disabled : Bool = false

  /* The offset of the dropdown from the input. */
  property offset : Number = 5

  style rect {
    background: #{Color.toCSSHex(value)};
    border: 1px solid var(--border);
    width: 2.5em;
  }

  style base {
    grid-template-columns: 1fr auto;
    display: grid;
  }

  /* Renders the date picker. */
  fun render : Html {
    try {
      panel =
        <Ui.AvoidFocus disableCursor={false}>
          <Ui.ColorPanel
            onChange={onChange}
            embedded={true}
            value={value}
            size={size}/>
        </Ui.AvoidFocus>

      label =
        Maybe::Just(
          <div::base>
            <span>
              <{ Color.toCSSHex(value) }>
            </span>

            <div::rect/>
          </div>)

      <Ui.Picker as picker
        icon={Ui.Icons:CHEVRON_DOWN}
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
