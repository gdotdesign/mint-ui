store Ui.Icons {
  state icons : Map(String, Tuple(Number, Number, Html)) = Map.empty()
  |> Map.set(
    "home",
    {
      16, 16, <path
        fill-rule="evenodd"
        d="M16 9l-3-3V2h-2v2L8 1 0 9h2l1 5c0 .55.45 1 1 1h8c.55 0 1-.45 1-1l1-5h2zm-4 5H9v-4H7v4H4L2.81 7.69 8 2.5l5.19 5.19L12 14z"/>
    })
  |> Map.set("arrow-right", {10, 16, <path d="M10 8L4 3v3H0v4h4v3l6-5z"/>})
  |> Map.set(
    "code",
    {
      14, 16, <path
        fill-rule="evenodd"
        d={
          "M9.5 3L8 4.5 11.5 8 8 11.5 9.5 13 14 8 9.5 3zm-5 0L0 8l4" \
          ".5 5L6 11.5 2.5 8 6 4.5 4.5 3z"
        }/>
    })
  |> Map.set(
    "desktop-download",
    {
      16,
      16,
      <path
        fill-rule="evenodd"
        d={
          "M4 6h3V0h2v6h3l-4 4-4-4zm11-4h-4v1h4v8H1V3h4V2H1c-.55 0-" \
          "1 .45-1 1v9c0 .55.45 1 1 1h5.34c-.25.61-.86 1.39-2.34 2h" \
          "8c-1.48-.61-2.09-1.39-2.34-2H15c.55 0 1-.45 1-1V3c0-.55-" \
          ".45-1-1-1z"
        }/>
    })
  |> Map.set(
    "alert",
    {
      16,
      16,
      <path
        d={
          "M8.893 1.5c-.183-.31-.52-.5-.887-.5s-.703.19-.886.5L.138" \
          " 13.499a.98.98 0 000 1.001c.193.31.53.501.886.501h13.964" \
          "c.367 0 .704-.19.877-.5a1.03 1.03 0 00.01-1.002L8.893 1." \
          "5zm.133 11.497H6.987v-2.003h2.039v2.003zm0-3.004H6.987V5" \
          ".987h2.039v4.006z"
        }/>
    })
  |> Map.set(
    "archive",
    {
      14,
      16,
      <path
        fill-rule="evenodd"
        d={
          "M13 2H1v2h12V2zM0 4a1 1 0 001 1v9a1 1 0 001 1h10a1 1 0 0" \
          "01-1V5a1 1 0 001-1V2a1 1 0 00-1-1H1a1 1 0 00-1 1v2zm2 1h" \
          "10v9H2V5zm2 3h6V7H4v1z"
        }/>
    })
  |> Map.set("arrow-both", {20, 16, <path d="M0 8l6-5v3h8V3l6 5-6 5v-3H6v3L0 8z"/>})
  |> Map.set("arrow-down", {10, 16, <path d="M7 7V3H3v4H0l5 6 5-6H7z"/>})
  |> Map.set("arrow-left", {10, 16, <path d="M6 3L0 8l6 5v-3h4V6H6V3z"/>})
  |> Map.set("arrow-up", {10, 16, <path d="M5 3L0 9h3v4h4V9h3L5 3z"/>})
  |> Map.set("arrow-small-down", {6, 16, <path d="M4 7V5H2v2H0l3 4 3-4H4z"/>})
  |> Map.set(
    "bell",
    {
      14, 16, <path
        d={
          "M14 12v1H0v-1l.73-.58c.77-.77.81-2.55 1.19-4.42C2.69 3.2" \
          "3 6 2 6 2c0-.55.45-1 1-1s1 .45 1 1c0 0 3.39 1.23 4.16 5 " \
          ".38 1.88.42 3.66 1.19 4.42l.66.58H14zm-7 4c1.11 0 2-.89 " \
          "2-2H5c0 1.11.89 2 2 2z"
        }/>
    })
  |> Map.set(
    "project",
    {
      16,
      16,
      <path
        fill-rule="evenodd"
        d={
          "M10 12h3V2h-3v10zm-4-2h3V2H6v8zm-4 4h3V2H2v12zm-1 1h13V1" \
          "H1v14zM14 0H1a1 1 0 00-1 1v14a1 1 0 001 1h13a1 1 0 001-1" \
          "V1a1 1 0 00-1-1z"
        }/>
    })
  |> Map.set(
    "plus",
    {
      12,
      16,
      <path
        fill-rule="evenodd"
        d="M12 9H7v5H5V9H0V7h5V2h2v5h5v2z"/>
    })
  |> Map.set(
    "search",
    {
      16,
      16,
      <path
        fill-rule="evenodd"
        d={
          "M15.7 13.3l-3.81-3.83A5.93 5.93 0 0013 6c0-3.31-2.69-6-6" \
          "-6S1 2.69 1 6s2.69 6 6 6c1.3 0 2.48-.41 3.47-1.11l3.83 3" \
          ".81c.19.2.45.3.7.3.25 0 .52-.09.7-.3a.996.996 0 000-1.41" \
          "v.01zM7 10.7c-2.59 0-4.7-2.11-4.7-4.7 0-2.59 2.11-4.7 4." \
          "7-4.7 2.59 0 4.7 2.11 4.7 4.7 0 2.59-2.11 4.7-4.7 4.7z"
        }/>
    })
}

component Ui.Icon {
  connect Ui.Icons exposing { icons }

  property name : String = ""
  property size : Number = 16

  style base {
    fill: currentColor;
  }

  fun render : Html {
    try {
      {width, height, content} =
        Map.getWithDefault(name, {0, 0, <></>}, icons)

      <svg::base
        viewBox="0 0 #{width} #{height}"
        height={Number.toString(size)}
        width={Number.toString(size)}
        aria-hidden="true"
        version="1.1">

        <{ content }>

      </svg>
    }
  }
}
