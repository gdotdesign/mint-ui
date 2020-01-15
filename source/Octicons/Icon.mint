component Octicon {
  property icon : String = ""
  property size : Number = 16

  style base {
    fill: currentColor;
  }

  get viewBox : String {
    case (icon) {
      "arrow-right" => "0 0 10 16"
      "arrow-both" => "0 0 20 16"
      "arrow-left" => "0 0 10 16"
      "arrow-down" => "0 0 10 16"
      "arrow-up" => "0 0 10 16"

      "arrow-small-down" => "0 0 6 16"

      "archive" => "0 0 14 16"
      "desktop-download" => "0 0 16 16"
      => "0 0 16 16"
    }
  }

  get content : Html {
    case (icon) {
      "desktop-download" =>
        <path
          fill-rule="evenodd"
          d={
            "M4 6h3V0h2v6h3l-4 4-4-4zm11-4h-4v1h4v8H1V3h4V2H1c-.55 0-" \
            "1 .45-1 1v9c0 .55.45 1 1 1h5.34c-.25.61-.86 1.39-2.34 2h" \
            "8c-1.48-.61-2.09-1.39-2.34-2H15c.55 0 1-.45 1-1V3c0-.55-" \
            ".45-1-1-1z"
          }/>

      "alert" =>
        <path
          d={
            "M8.893 1.5c-.183-.31-.52-.5-.887-.5s-.703.19-.886.5L.138" \
            " 13.499a.98.98 0 000 1.001c.193.31.53.501.886.501h13.964" \
            "c.367 0 .704-.19.877-.5a1.03 1.03 0 00.01-1.002L8.893 1." \
            "5zm.133 11.497H6.987v-2.003h2.039v2.003zm0-3.004H6.987V5" \
            ".987h2.039v4.006z"
          }/>

      "archive" =>
        <path
          fill-rule="evenodd"
          d={
            "M13 2H1v2h12V2zM0 4a1 1 0 001 1v9a1 1 0 001 1h10a1 1 0 0" \
            "01-1V5a1 1 0 001-1V2a1 1 0 00-1-1H1a1 1 0 00-1 1v2zm2 1h" \
            "10v9H2V5zm2 3h6V7H4v1z"
          }/>

      "arrow-both" => <path d="M0 8l6-5v3h8V3l6 5-6 5v-3H6v3L0 8z"/>
      "arrow-down" => <path d="M7 7V3H3v4H0l5 6 5-6H7z"/>
      "arrow-left" => <path d="M6 3L0 8l6 5v-3h4V6H6V3z"/>
      "arrow-right" => <path d="M10 8L4 3v3H0v4h4v3l6-5z"/>
      "arrow-up" => <path d="M5 3L0 9h3v4h4V9h3L5 3z"/>
      "arrow-small-down" => <path d="M4 7V5H2v2H0l3 4 3-4H4z"/>

      => <></>
    }
  }

  fun render : Html {
    <svg::base
      height={Number.toString(size)}
      width={Number.toString(size)}
      aria-hidden="true"
      viewBox={viewBox}
      version="1.1">

      <{ content }>

    </svg>
  }
}
