component Ui.Toolbar.Link {
  property target : String = ""
  property label : String = ""
  property href : String = ""

  style base {
    font-size: 18px;

    a {
      cursor: pointer;
      display: block;
      color: inherit;

      &:focus,
      &:hover {
        color: inherit;
      }
    }
  }

  fun render : Html {
    <div::base>
      <Ui.Link
        target={target}
        label={label}
        href={href}/>
    </div>
  }
}
