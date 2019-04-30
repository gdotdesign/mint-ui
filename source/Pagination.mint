component Ui.Pagination {
  property onChange : Function(Number, a) = (page : Number) : Void { void }
  property sidePages : Number = 2
  property perPage : Number = 10
  property total : Number = 0
  property page : Number = 0

  style base {
    align-items: center;
    display: flex;

    & * + * {
      margin-left: 5px;
    }
  }

  style span {
    margin: 0 5px 0 10px;

    &:before {
      content: "\\2219 \\2219 \\2219";
      line-height: 8px;
    }
  }

  get pages : Number {
    Math.floor(Math.max(total - 1, 0) / perPage)
  }

  get buttonRange : Array(Number) {
    Array.range(
      Math.max(1, page - sidePages),
      Math.min(page + sidePages + 1, pages))
  }

  get buttons : Array(Html) {
    for (index of buttonRange) {
      <Ui.Button
        onClick={(event : Html.Event) : a { onChange(index) }}
        key={Number.toString(index)}
        outline={index != page}>

        <{ Number.toString(index + 1) }>

      </Ui.Button>
    }
  }

  get previousButton : Html {
    if (page != 0 && pages > 0) {
      <Ui.Button
        onClick={(event : Html.Event) : a { onChange(page - 1) }}
        outline={true}>

        "Prev"

      </Ui.Button>
    } else {
      Html.empty()
    }
  }

  get nextButton : Html {
    if (page != pages && pages > 0) {
      <Ui.Button
        onClick={(event : Html.Event) : a { onChange(page + 1) }}
        outline={true}>

        "Next"

      </Ui.Button>
    } else {
      Html.empty()
    }
  }

  get leftDots : Html {
    if (sidePages < (page - 1) && pages > 0) {
      <span::span/>
    } else {
      Html.empty()
    }
  }

  get rightDots : Html {
    if ((page + sidePages + 1 < pages) && pages > 0) {
      <span::span/>
    } else {
      Html.empty()
    }
  }

  get rightButton : Html {
    if (pages > 1) {
      <Ui.Button
        onClick={(event : Html.Event) : a { onChange(pages) }}
        outline={page != pages}>

        "1"

      </Ui.Button>
    } else {
      Html.empty()
    }
  }

  get leftButton : Html {
    if (pages >= 1) {
      <Ui.Button
        onClick={(event : Html.Event) : a { onChange(0) }}
        outline={page != 0}>

        <{ Number.toString(pages + 1) }>

      </Ui.Button>
    } else {
      Html.empty()
    }
  }

  fun render : Html {
    <div::base>
      <{ previousButton }>

      <{ leftButton }>

      <{ leftDots }>
      <{ buttons }>
      <{ rightDots }>

      <{ rightButton }>

      <{ nextButton }>
    </div>
  }
}
