component Ui.ScrollPanel {
  property children : Array(Html) = []
  property animateScroll : Bool = false
  property shadowSize : Number = 20
  property maxHeight : Number = 300
  property minWidth : Number = 350

  state showBottom : Bool = false
  state showTop : Bool = false

  use Provider.AnimationFrame { frames = frames }

  style base {
    scrollbar-color: rgba(0,0,0,0.15) transparent;
    scroll-behavior: #{scrollBehavior};

    padding-right: #{paddingRight}px;
    overflow-y: auto;

    max-height: #{maxHeight}px;
    min-width: #{minWidth}px;

    &::-webkit-scrollbar {
      width: 10px;
    }

    &::-webkit-scrollbar-track {
      background: transparent;
    }

    &::-webkit-scrollbar-thumb {
      background: rgba(0,0,0,0.15);
    }

    &::-webkit-scrollbar-thumb:hover {
      background: rgba(0,0,0,0.2);
    }
  }

  style top {
    transition: opacity 200ms;
    pointer-events: none;
    position: sticky;
    top: 0;

    background: radial-gradient(ellipse farthest-side at top center, rgba(0,0,0,0.1), transparent);
    border-image: linear-gradient(90deg, rgba(0,0,0,0), rgba(0,0,0,0.2), rgba(0,0,0,0)) 1;
    border-top: 1px solid;

    margin-top: -#{shadowSize}px;
    opacity: #{topOpacity};
    height: #{shadowSize}px;
  }

  style bottom {
    transition: opacity 200ms;
    pointer-events: none;
    position: sticky;
    bottom: 0;

    background: radial-gradient(ellipse farthest-side at bottom center, rgba(0,0,0,0.1), transparent);
    border-image: linear-gradient(90deg, rgba(0,0,0,0), rgba(0,0,0,0.2), rgba(0,0,0,0)) 1;
    border-bottom: 1px solid;

    margin-top: -#{shadowSize}px;
    opacity: #{bottomOpacity};
    height: #{shadowSize}px;
  }

  get scrollBehavior : String {
    if (animateScroll) {
      "smooth"
    } else {
      "auto"
    }
  }

  get paddingRight : Number {
    if (showTop || showBottom) {
      4
    } else {
      0
    }
  }

  get topOpacity : Number {
    if (showTop) {
      1
    } else {
      0
    }
  }

  get bottomOpacity : Number {
    if (showBottom) {
      1
    } else {
      0
    }
  }

  fun frames : Promise(Never, Void) {
    try {
      nextShowTop =
        `#{base}._0.scrollTop > 0`

      nextShowBottom =
        `#{base}._0.clientHeight + #{base}._0.scrollTop <= #{base}._0.scrollHeight - #{shadowSize}`

      if (showTop != nextShowTop || showBottom != nextShowBottom) {
        next
          {
            showBottom = nextShowBottom,
            showTop = nextShowTop
          }
      } else {
        `null`
      }
    }
  }

  fun render : Html {
    <div::base as base>
      <div::top/>

      <{ children }>

      <div::bottom/>
    </div>
  }
}
