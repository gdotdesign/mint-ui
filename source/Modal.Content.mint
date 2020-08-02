/* The content part of a modal, with a title, error, content and actions. */
component Ui.Modal.Content {
  connect Ui exposing { mobile, darkMode, resolveTheme }

  /* The theme for the component. */
  property theme : Maybe(Ui.Theme) = Maybe::Nothing

  /* The content to display in the body of the modal. */
  property content : Html = <></>

  /* The content to display in the footer of the modal. */
  property actions : Html = <></>

  /* The content to display in the title of the modal. */
  property title : Html = <></>

  /* The content to display in the error part of the modal. */
  property error : Html = <></>

  /* The icon to display in the header. */
  property icon : Html = <></>

  /* The maximum width of the modal. */
  property maxWidth : Number = 500

  /* The minimum width of the modal. */
  property minWidth : Number = 500

  /* The size of the modal. */
  property size : Number = 16

  /* Styles for the base element. */
  style base {
    box-shadow: 0 0 1.25em rgba(0, 0, 0, 0.5);
    font-family: #{actualTheme.fontFamily};
    border-radius: 0.375em;
    font-size: #{size}px;

    position: relative;
    z-index: 1;

    flex-direction: column;
    display: flex;
  }

  /* Style for the header. */
  style header {
    background: #{actualTheme.contentFaded.color};
    color: #{actualTheme.contentFaded.text};

    border-radius: 0.375em 0.375em 0 0;
    padding: 1em;

    align-items: center;
    display: flex;

    if (!Html.Extra.isNotEmpty(error)) {
      border-bottom: 0.0625em solid #{actualTheme.border};
    }
  }

  /* Style for the title. */
  style title {
    font-size: 1.375em;
    margin-right: auto;
    font-weight: bold;

    if (mobile) {
      font-size: 1em;
    }
  }

  /* Style for the content. */
  style content {
    background: #{actualTheme.content.color};
    color: #{actualTheme.content.text};

    max-width: #{maxWidth}px;
    min-width: #{minWidth}px;

    line-height: 1.5;
    padding: 1em;
    flex: 1;

    if (mobile) {
      min-width: 0;
    }
  }

  /* Style for the actions. */
  style actions {
    background: #{actualTheme.contentFaded.color};
    color: #{actualTheme.contentFaded.text};

    border-top: 0.0625em solid #{actualTheme.border};
    border-radius: 0 0 0.375em 0.375em;
    padding: 1em;

    justify-content: flex-end;
    grid-auto-flow: column;
    grid-gap: 1em;
    display: grid;
  }

  /* Style for the icon. */
  style icon {
    border-right: 0.125em solid #{actualTheme.border};
    padding-right: 1em;
    margin-right: 1em;

    justify-content: center;
    align-items: center;
    display: flex;

    if (mobile) {
      display: none;
    }

    &:empty {
      display: none;
    }
  }

  /* Style for the error. */
  style error {
    padding: 1em;

    if (darkMode) {
      border-bottom: 0.0625em solid #{actualTheme.danger.s900.color};
      border-top: 0.0625em solid #{actualTheme.danger.s900.color};
      background: #{actualTheme.danger.s800.color};
      color: #{actualTheme.danger.s50.color};
    } else {
      border-bottom: 0.0625em solid #{actualTheme.danger.s100.color};
      border-top: 0.0625em solid #{actualTheme.danger.s100.color};
      background: #{actualTheme.danger.s50.color};
      color: #{actualTheme.danger.s600.color};
    }
  }

  /* Returns the actual theme. */
  get actualTheme : Ui.Theme.Resolved {
    resolveTheme(theme)
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::header>
        if (Html.Extra.isNotEmpty(icon)) {
          <div::icon>
            <Ui.Icon
              size={1.375 * size}
              icon={icon}/>
          </div>
        }

        <div::title>
          <{ title }>
        </div>

        <Ui.Icon
          onClick={(event : Html.Event) { Ui.Modal.cancel() }}
          interactive={true}
          icon={Ui.Icons:X}/>
      </div>

      if (Html.Extra.isNotEmpty(error)) {
        <div::error>
          <{ error }>
        </div>
      }

      <div::content>
        <{ content }>
      </div>

      if (Html.Extra.isNotEmpty(actions)) {
        <div::actions>
          <{ actions }>
        </div>
      }
    </div>
  }
}
