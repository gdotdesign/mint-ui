component Ui.Toolbar.Title {
  property children : Array(Html) = []
  property href : String = ""

  style base {
    font-family: sans;
    font-weight: bold;
    font-size: 22px;

    > a,
    &:hover > a,
    > a:focus {
      color: inherit;
    }

    &:not(:first-child) {
      margin-left: 15px;
    }
  }

  fun render : Html {
    <div::base>
      <a href={href}>
        <{ children }>
      </a>
    </div>
  }
}
