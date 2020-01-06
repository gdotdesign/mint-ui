component Ui.Breadcrumb {
  connect Ui exposing { theme }

  property children : Array(Html) = []
  property target : String = ""
  property label : String = ""
  property type : String = ""
  property href : String = ""

  style base {
    display: inline-block;

    &:hover,
    a:focus {
      color: #{theme.hover.color};
    }
  }

  fun render : Html {
    <div::base>
      <Ui.Link
        children={children}
        target={target}
        type="inherit"
        label={label}
        href={href}/>
    </div>
  }
}

component Ui.Breadcrumbs {
  connect Ui exposing { theme }

  property children : Array(Html) = []
  property separator : String = "|"

  style separator {
    display: inline-block;
    margin: 0 12px;
    opacity: 0.4;
  }

  style base {
    background: #{theme.colors.inputSecondary.background};
    color: #{theme.colors.inputSecondary.text};
    font-family: #{theme.fontFamily};
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
