component Ui.FloatingButton {
  connect Ui exposing { resolveTheme }

  property onClick : Function(Promise(Never, Void)) = Promise.never
  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property size : Number = 60
  property icon : Html

  get actualTheme {
    resolveTheme(theme)
  }

  style base {
    box-shadow: 0 0 #{size * 0.08}px rgba(0,0,0,0.25);

    background: #{actualTheme.primary.s500.color};
    border-radius: 50%;

    height: #{size}px;
    width: #{size}px;

    cursor: pointer;
    color: white;

    justify-content: center;
    align-items: center;
    display: flex;
  }

  fun render : Html {
    <div::base onClick={onClick}>
      <Ui.Icon
        size={size / 2}
        icon={icon}/>
    </div>
  }
}
