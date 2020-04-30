component Ui.Breadcrumbs {
  connect Ui exposing {
    surfaceBackground,
    surfaceText,
    fontFamily
  }

  property children : Array(Html) = []

  property separator : Html =
    <>
      "/"
    </>

  style separator {
    display: inline-block;
    margin: 0 12px;
    opacity: 0.4;
  }

  style base {
    background: #FCFCFC;
    font-family: #{fontFamily};
    color: #444;
    padding: 14px 32px;
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
