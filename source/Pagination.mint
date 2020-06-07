component Ui.Pagination {
  property onChange : Function(Number, Promise(Never, Void)) = Promise.Extra.never1
  property disabled : Bool = false
  property sidePages : Number = 2
  property perPage : Number = 10
  property total : Number = 0
  property size : Number = 16
  property page : Number = 0

  style base {
    width: min-content;
  }

  style ellipsis {
    font-size: #{size}px;

    &:before {
      content: "\\2219 \\2219 \\2219";
    }
  }

  fun renderButton (data : Tuple(Number, Bool, String, String)) : Html {
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
        Number.toString(page) + label + icon

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

  fun render : Html {
    <div::base>
      <Ui.LineGrid gap={size * 0.625}>
        /* First page button */
        if (!Array.contains(0, buttonRange)) {
          renderButton({0, false, "", "double-chevron-left"})
        }

        /* Previous button */
        if (page > 0) {
          renderButton({page - 1, false, "", "chevron-left"})
        }

        /* Left ellipsis */
        if (sidePages < (page - 1) && pages > 0) {
          <span::ellipsis/>
        }

        for (index of buttonRange) {
          renderButton({index, index == page, Number.toString(index + 1), ""})
        }

        /* Right ellipsis */
        if ((page + sidePages + 1 < pages) && pages > 0) {
          <span::ellipsis/>
        }

        /* Next page button */
        if (page < pages && pages > 0) {
          renderButton({page + 1, false, "", "chevron-right"})
        }

        /* Last page button */
        if (page < pages && !Array.contains(pages, buttonRange)) {
          renderButton({pages, false, "", "double-chevron-right"})
        }
      </Ui.LineGrid>
    </div>
  } where {
    buttonRange =
      Array.range(
        Math.max(0, page - sidePages),
        Math.min(page + sidePages, pages))

    pages =
      Math.floor(Math.max(total - 1, 0) / perPage)
  }
}
