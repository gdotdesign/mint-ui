component Ui.Breadcrumb {
  property children : Array(Html) = []
  property target : String = ""
  property label : String = ""
  property type : String = ""
  property href : String = ""

  style base {
    display: inline-block;

    &:hover,
    a:focus {
      color: red;
    }
  }

  fun render : Html {
    <div::base>
      <a
        target={target}
        href={href}>

        <{ children }>

      </a>
    </div>
  }
}

component Ui.Breadcrumbs {
  connect Ui exposing { fontFamily }

  property children : Array(Html) = []
  property separator : String = "|"

  style separator {
    display: inline-block;
    margin: 0 12px;
    opacity: 0.4;
  }

  style base {
    background: red;
    color: yellow;
    font-family: #{fontFamily};
    padding: 14px 24px;
  }

  get span : Html {
    <span::separator>
      <{ separator }>
    </span>
  }

  fun render : Html {
    <div::base>
      <{ Array.intersperse(span, children) }>
    </div>
  }
}
