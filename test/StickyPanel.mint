component Ui.StickyPanel.Test {
  property position : String = "top-left"

  style base {
    justify-content: center;
    align-items: center;
    display: flex;

    position: absolute;
    height: 500px;
    width: 500px;
    left: 0;
    top: 0;
  }

  style element {
    background: red;
    height: 100px;
    width: 100px;
  }

  style content {
    background: yellow;
    height: 50px;
    width: 50px;
  }

  fun render : Html {
    <div::base id="base">
      <Ui.StickyPanel
        content={<div::content id="content"/>}
        element={<div::element id="element"/>}
        position={position}
        offset={10}/>
    </div>
  }
}

suite "Ui.StickyPanel" {
  test "fills the window correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test/>
      |> start()
      |> find("#base")
      |> assertTop(0)
      |> assertLeft(0)
      |> assertWidth(500)
      |> assertHeight(500)
    }
  }

  test "positions the element correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test/>
      |> start()
      |> find("#element")
      |> assertTop(200)
      |> assertLeft(200)
      |> assertWidth(100)
      |> assertHeight(100)
    }
  }

  test "positions the top-left correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(140)
      |> assertLeft(200)
    }
  }

  test "positions the top-right correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="top-right"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(140)
      |> assertLeft(250)
    }
  }

  test "positions the top-center correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="top-center"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(140)
      |> assertLeft(225)
    }
  }

  test "positions the bottom-left correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="bottom-left"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(310)
      |> assertLeft(200)
    }
  }

  test "positions the bottom-right correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="bottom-right"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(310)
      |> assertLeft(250)
    }
  }

  test "positions the bottom-center correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="bottom-center"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(310)
      |> assertLeft(225)
    }
  }

  test "positions the left-top correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="left-top"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(200)
      |> assertLeft(140)
    }
  }

  test "positions the left-center correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="left-center"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(225)
      |> assertLeft(140)
    }
  }

  test "positions the left-bottom correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="left-bottom"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(250)
      |> assertLeft(140)
    }
  }

  test "positions the right-top correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="right-top"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(200)
      |> assertLeft(310)
    }
  }

  test "positions the right-center correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="right-center"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(225)
      |> assertLeft(310)
    }
  }

  test "positions the right-bottom correctly" {
    with Test.Html {
      <Ui.StickyPanel.Test position="right-bottom"/>
      |> start()
      |> findGlobally("#content")
      |> assertTop(250)
      |> assertLeft(310)
    }
  }
}
