component Ui.Pagination {
  property onChange : Function(Number, Void) = (page : Number) : Void => { void }
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
    Array.map(
      (index : Number) : Html => {
        <Ui.Button
          onClick={(event : Html.Event) : Void => { onChange(index) }}
          label={Number.toString(index + 1)}
          key={Number.toString(index)}
          outline={index != page}/>
      },
      buttonRange)
  }

  get previousButton : Html {
    if (page != 0 && pages > 0) {
      <Ui.Button
        onClick={(event : Html.Event) : Void => { onChange(page- 1) }}
        outline={true}
        label="Prev"/>
    } else {
      Html.empty()
    }
  }

  get nextButton : Html {
    if (page != pages && pages > 0) {
      <Ui.Button
        onClick={(event : Html.Event) : Void => { onChange(page+ 1) }}
        outline={true}
        label="Next"/>
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
        onClick={(event : Html.Event) : Void => { onChange(pages) }}
        label={Number.toString(pages + 1)}
        outline={page != pages}/>
    } else {
      Html.empty()
    }
  }

  get leftButton : Html {
    if (pages >= 1) {
      <Ui.Button
        onClick={(event : Html.Event) : Void => { onChange(0) }}
        outline={page != 0}
        label="1"/>
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
