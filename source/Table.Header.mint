component Ui.Table.Header {
  connect Ui exposing { resolveTheme }

  property onOrderChange : Function(Tuple(String, String), Promise(Never, Void)) = Promise.Extra.never1
  property theme : Maybe(Ui.Theme) = Maybe::Nothing
  property orderDirection : String = ""
  property orderBy : String = ""

  property data : Ui.Table.Header =
    {
      sortable = false,
      shrink = false,
      sortKey = "",
      label = ""
    }

  style base {
    white-space: #{whiteSpace};
    width: #{width};
  }

  style wrap {
    grid-template-columns: 1fr min-content;
    align-items: center;
    grid-gap: 10px;
    display: grid;
  }

  style icon {
    opacity: #{opacity};
    line-height: 0;

    &:hover {
      color: #{actualTheme.primary.s500.color};
      cursor: pointer;
      opacity: 1;
    }
  }

  get actualTheme {
    resolveTheme(theme)
  }

  get opacity : Number {
    if (orderBy == data.sortKey) {
      1
    } else {
      0.5
    }
  }

  get width : String {
    if (data.shrink) {
      "1%"
    } else {
      "initial"
    }
  }

  get whiteSpace : String {
    if (data.shrink) {
      "nowrap"
    } else {
      "initial"
    }
  }

  fun handleSort : Promise(Never, Void) {
    sequence {
      nextOrderDirection =
        if (orderBy == data.sortKey) {
          if (orderDirection == "asc") {
            "desc"
          } else {
            "asc"
          }
        } else {
          "asc"
        }

      onOrderChange({data.sortKey, nextOrderDirection})
    }
  }

  fun render : Html {
    <th::base>
      <div::wrap>
        <span>
          <{ data.label }>
        </span>

        if (data.sortable) {
          <div::icon onClick={handleSort}>
            if (orderBy == data.sortKey) {
              if (orderDirection == "desc") {
                <Ui.Icon name="triangle-down"/>
              } else {
                <Ui.Icon name="triangle-up"/>
              }
            } else {
              <Ui.Icon name="triangle-up-down"/>
            }
          </div>
        } else {
          <></>
        }
      </div>
    </th>
  }
}
