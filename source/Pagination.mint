/* A component for displaying buttons for paginatable content. */
component Ui.Pagination {
  /* The change event handler. */
  property onChange : Function(Number, Promise(Never, Void)) = Promise.never1

  /* Wether or not the pagination is disabled. */
  property disabled : Bool = false

  /* How many side pages to render. */
  property sidePages : Number = 2

  /* How many items are in one page. */
  property perPage : Number = 10

  /* The total number of items. */
  property total : Number = 0

  /* The size of the component. */
  property size : Number = 16

  /* The current page. */
  property page : Number = 0

  /* Style for the base element. */
  style base {
    width: min-content;
  }

  /* Style for the ellipsis between the buttons. */
  style ellipsis {
    white-space: nowrap;
    font-size: #{size}px;

    &:before {
      content: "\\2219 \\2219 \\2219";
    }
  }

  /* Renders a button. */
  fun renderButton (data : Tuple(Number, Bool, String, Html)) : Html {
    try {
      {page, active, label, icon} =
        data

      type =
        if (active) {
          "primary"
        } else {
          "surface"
        }

      key =
        Number.toString(page) + label

      <Ui.Button
        onClick={(event : Html.Event) { onChange(page) }}
        disabled={disabled}
        iconBefore={icon}
        ellipsis={false}
        label={label}
        type={type}
        size={size}
        key={key}/>
    }
  }

  /* Renders the pagination. */
  fun render : Html {
    try {
      buttonRange =
        Array.range(
          Math.max(0, page - sidePages),
          Math.min(page + sidePages, pages))

      pages =
        Math.floor(Math.max(total - 1, 0) / perPage)

      <div::base>
        <Ui.LineGrid gap={size * 0.625}>
          /* First page button */
          if (!Array.contains(0, buttonRange)) {
            renderButton({0, false, "", Ui.Icons:DOUBLE_CHEVRON_LEFT})
          }

          /* Previous button */
          if (page > 0) {
            renderButton({page - 1, false, "", Ui.Icons:CHEVRON_LEFT})
          }

          /* Left ellipsis */
          if (sidePages < (page - 1) && pages > 0) {
            <span::ellipsis/>
          }

          for (index of buttonRange) {
            renderButton({index, index == page, Number.toString(index + 1), <></>})
          }

          /* Right ellipsis */
          if ((page + sidePages + 1 < pages) && pages > 0) {
            <span::ellipsis/>
          }

          /* Next page button */
          if (page < pages && pages > 0) {
            renderButton({page + 1, false, "", Ui.Icons:CHEVRON_RIGHT})
          }

          /* Last page button */
          if (page < pages && !Array.contains(pages, buttonRange)) {
            renderButton({pages, false, "", Ui.Icons:DOUBLE_CHEVRON_RIGHT})
          }
        </Ui.LineGrid>
      </div>
    }
  }
}
