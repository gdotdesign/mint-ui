/* A table header component. */
component Ui.Table.Header {
  connect Ui exposing { resolveTheme }

  /* The handler for the order change event. */
  property onOrderChange : Function(Tuple(String, String), Promise(Never, Void)) = Promise.never1

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The order direction either "asc" or "desc". */
  property orderDirection : String = ""

  /* The `sortKey` of the column which the content is ordered by. */
  property orderBy : String = ""

  /* The data for the header. */
  property data : Ui.Table.Header

  /* Style for the base. */
  style base {
    if (data.shrink) {
      white-space: nowrap;
      width: 1%;
    } else {
      white-space: initial;
      width: initial;
    }
  }

  /* Style for a header. */
  style wrap {
    grid-template-columns: 1fr min-content;
    align-items: center;
    grid-gap: 10px;
    display: grid;
  }

  /* Style for the icon. */
  style icon {
    line-height: 0;

    if (orderBy == data.sortKey) {
      opacity: 1;
    } else {
      opacity: 0.5;
    }

    &:hover {
      color: #{actualTheme.primary.s500.color};
      cursor: pointer;
      opacity: 1;
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* The handler for the icon. */
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
                <Ui.Icon icon={Ui.Icons:TRIANGLE_DOWN}/>
              } else {
                <Ui.Icon icon={Ui.Icons:TRIANGLE_UP}/>
              }
            } else {
              <Ui.Icon icon={Ui.Icons:TRIANGLE_UP_DOWN}/>
            }
          </div>
        }
      </div>
    </th>
  }
}
