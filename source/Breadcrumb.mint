component Ui.Breadcrumb {
  connect Ui exposing {
    primaryBackground,
    contentTextFaded,
    contentText
  }

  property children : Array(Html) = []
  property target : String = ""
  property label : String = ""
  property type : String = ""
  property href : String = ""
  property active : Bool = false

  style base {
    display: inline-block;

    if (active) {
      color: #333;
    }
  }

  style link {
    outline: none;

    text-decoration-color: #BBB;
    color: #444;

    &::-moz-focus-inner {
      border: 0;
    }

    &:hover,
    &:focus {
      text-decoration-color: #{primaryBackground};
      color: #{primaryBackground};
    }
  }

  fun render : Html {
    <nav::base aria-label="breadcrumb">
      if (String.isEmpty(href)) {
        <span>
          <{ children }>
        </span>
      } else {
        <a::link
          target={target}
          href={href}>

          <{ children }>

        </a>
      }
    </nav>
  }
}
