component Ui.Table.Th {
  property align : String = "left"
  property width : String = "auto"

  property children : Array(Html) = []

  fun render : Html {
    <Ui.Table.Td
      children={children}
      header={true}
      align={align}
      width={width}/>
  }
}
