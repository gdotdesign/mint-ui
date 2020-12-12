component Ui.NavItems {
  property items : Array(Ui.NavItem) = []

  /* Styles for the containers of items. */
  style items {
    align-content: start;
    grid-gap: 0.5em;
    display: grid;
  }

  fun render : Html {
    <div::items>
      for (item of items) {
        <Ui.NavItem item={item}/>
      }
    </div>
  }
}
