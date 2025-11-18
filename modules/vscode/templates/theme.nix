colors:
let
  hashed = colors.withHashtag;
  inherit (hashed)
    base00
    base01
    base02
    base03
    base04
    base05
    # base06
    base07
    base08
    base09
    base0A
    base0B
    base0C
    base0D
    base0E
    base0F
    ;

  withAlpha = color: alpha: "${color}${alpha}";

  luminance =
    name:
    let
      r = builtins.fromJSON colors."${name}-dec-r";
      g = builtins.fromJSON colors."${name}-dec-g";
      b = builtins.fromJSON colors."${name}-dec-b";
    in
    0.2126 * r + 0.7152 * g + 0.0722 * b;

  themeType =
    if (luminance "base00") <= (luminance "base05") then "dark" else "light";

  surfaces = {
    base = base00;
    raised = base00;
    overlay = base02;
    selectionStrong =
      if themeType == "dark" then withAlpha base02 "cc" else withAlpha base02 "80";

    selectionSoft =
      if themeType == "dark" then withAlpha base02 "66" else withAlpha base02 "40";
    selectionFaint = withAlpha base02 "33";
  };

  outlines = {
    neutral = base03;
    focus = base0D;
  };

  textColors = {
    primary = base05;
    secondary = base04;
    disabled = withAlpha base04 "99";
    inverse = base00;
  };

  accent = {
    primary = base0D;
    secondary = base0E;
    info = base0C;
    success = base0B;
    warn = base0A;
    urgent = base09;
    error = base08;
    deprecated = base0F;
  };

  lineHighlight = withAlpha base01 "66";
  shadow = "#00000050";
  ghostText = withAlpha base05 "33";
  subtleBorder = withAlpha outlines.neutral "80";

  mergeSets = sets: builtins.foldl' (acc: value: acc // value) { } sets;

  baseColors = {
    "foreground" = textColors.primary;
    "descriptionForeground" = textColors.secondary;
    "disabledForeground" = textColors.disabled;
    "errorForeground" = accent.error;
    "icon.foreground" = textColors.primary;
    "selection.background" = surfaces.selectionStrong;
    "focusBorder" = outlines.focus;
    "widget.shadow" = shadow;
  };

  windowColors = {
    "window.activeBorder" = outlines.neutral;
    "window.inactiveBorder" = subtleBorder;
    "titleBar.activeBackground" = surfaces.raised;
    "titleBar.activeForeground" = textColors.primary;
    "titleBar.inactiveBackground" = surfaces.raised;
    "titleBar.inactiveForeground" = textColors.disabled;
    "titleBar.border" = outlines.neutral;
    "commandCenter.background" = surfaces.raised;
    "commandCenter.foreground" = textColors.primary;
    "commandCenter.activeBackground" = surfaces.selectionSoft;
    "commandCenter.activeForeground" = textColors.primary;
    "commandCenter.border" = outlines.neutral;
  };

  navigationColors = {
    "activityBar.background" = surfaces.raised;
    "activityBar.border" = outlines.neutral;
    "activityBar.foreground" = textColors.primary;
    "activityBar.inactiveForeground" = textColors.secondary;
    "activityBar.activeBorder" = outlines.focus;
    "activityBar.dropBorder" = outlines.focus;
    "activityBar.activeBackground" = surfaces.selectionSoft;
    "activityBar.activeFocusBorder" = outlines.focus;
    "activityBarBadge.background" = accent.primary;
    "activityBarBadge.foreground" = textColors.primary;
    "sideBar.background" = surfaces.raised;
    "sideBar.border" = outlines.neutral;
    "sideBar.foreground" = textColors.primary;
    "sideBarTitle.foreground" = textColors.secondary;
    "sideBarSectionHeader.background" = surfaces.base;
    "sideBarSectionHeader.foreground" = textColors.primary;
    "sideBar.dropBackground" = surfaces.selectionFaint;
    "panel.background" = surfaces.base;
    "panel.border" = outlines.neutral;
    "panelSectionHeader.background" = surfaces.raised;
    "panelSectionHeader.foreground" = textColors.secondary;
    "panelInput.border" = outlines.neutral;
    "panelTitle.activeForeground" = textColors.primary;
    "panelTitle.activeBorder" = outlines.focus;
    "panelTitle.inactiveForeground" = textColors.secondary;
    "panelSectionHeader.border" = outlines.neutral;
    "breadcrumb.background" = surfaces.raised;
    "breadcrumb.foreground" = textColors.secondary;
    "breadcrumb.focusForeground" = textColors.primary;
    "breadcrumb.activeSelectionForeground" = textColors.primary;
    "breadcrumbPicker.background" = surfaces.raised;
  };

  statusAndNotificationColors = {
    "statusBar.background" = surfaces.raised;
    "statusBar.foreground" = textColors.primary;
    "statusBar.border" = outlines.neutral;
    "statusBar.debuggingBackground" = accent.primary;
    "statusBar.debuggingForeground" = textColors.inverse;
    "statusBar.noFolderBackground" = surfaces.base;
    "statusBarItem.focusBorder" = outlines.focus;
    "statusBarItem.hoverBackground" = surfaces.selectionSoft;
    "statusBarItem.remoteBackground" = accent.secondary;
    "statusBarItem.remoteForeground" = textColors.inverse;
    "banner.background" = surfaces.raised;
    "banner.foreground" = textColors.primary;
    "banner.iconForeground" = accent.primary;
    "notificationCenter.border" = outlines.neutral;
    "notificationCenterHeader.background" = surfaces.raised;
    "notificationCenterHeader.foreground" = textColors.secondary;
    "notifications.background" = surfaces.raised;
    "notifications.foreground" = textColors.primary;
    "notifications.border" = outlines.neutral;
    "notificationToast.border" = outlines.neutral;
    "notificationLink.foreground" = accent.primary;
  };

  buttonAndInputColors = {
    "button.background" = accent.primary;
    "button.foreground" = textColors.inverse;
    "button.hoverBackground" = withAlpha accent.primary "e6";
    # "button.border" = "transparent"; FIX: invalid color format
    "button.secondaryBackground" = surfaces.raised;
    "button.secondaryForeground" = textColors.primary;
    "button.secondaryHoverBackground" = surfaces.selectionSoft;
    "button.separator" = subtleBorder;
    "checkbox.background" = surfaces.raised;
    "checkbox.border" = outlines.neutral;
    "checkbox.foreground" = textColors.primary;
    "dropdown.background" = surfaces.raised;
    "dropdown.foreground" = textColors.primary;
    "dropdown.border" = outlines.neutral;
    "input.background" = surfaces.raised;
    "input.foreground" = textColors.primary;
    "input.border" = outlines.neutral;
    "input.placeholderForeground" = textColors.disabled;
    "inputOption.activeBorder" = outlines.focus;
    "inputOption.activeBackground" = surfaces.selectionSoft;
    "inputValidation.infoBorder" = accent.info;
    "inputValidation.infoBackground" = withAlpha accent.info "26";
    "inputValidation.infoForeground" = textColors.primary;
    "inputValidation.warningBorder" = accent.warn;
    "inputValidation.warningBackground" = withAlpha accent.warn "26";
    "inputValidation.warningForeground" = textColors.primary;
    "inputValidation.errorBorder" = accent.error;
    "inputValidation.errorBackground" = withAlpha accent.error "26";
    "inputValidation.errorForeground" = textColors.inverse;
  };

  listAndTreeColors = {
    "list.activeSelectionBackground" = surfaces.selectionStrong;
    "list.activeSelectionForeground" = textColors.primary;
    "list.focusBackground" = surfaces.selectionStrong;
    "list.focusForeground" = textColors.primary;
    "list.hoverBackground" = surfaces.selectionSoft;
    "list.inactiveSelectionBackground" = surfaces.selectionSoft;
    "list.inactiveSelectionForeground" = textColors.primary;
    "list.dropBackground" = surfaces.selectionFaint;
    "list.highlightForeground" = accent.primary;
    "list.errorForeground" = accent.error;
    "list.warningForeground" = accent.warn;
    "tree.indentGuidesStroke" = subtleBorder;
    "tree.inactiveIndentGuidesStroke" = subtleBorder;
  };

  tabsAndEditorGroupColors = {
    "editorGroup.border" = outlines.neutral;
    "editorGroupHeader.noTabsBackground" = surfaces.raised;
    "editorGroupHeader.tabsBackground" = surfaces.raised;
    "editorGroupHeader.tabsBorder" = outlines.neutral;
    "editorGroup.dropBackground" = surfaces.selectionFaint;
    "tab.activeBackground" = surfaces.base;
    "tab.activeForeground" = textColors.primary;
    "tab.activeBorderTop" = outlines.focus;
    "tab.inactiveBackground" = surfaces.raised;
    "tab.inactiveForeground" = textColors.secondary;
    "tab.border" = outlines.neutral;
    "tab.hoverBackground" = surfaces.selectionSoft;
    "tab.unfocusedHoverBackground" = surfaces.selectionSoft;
    "tab.hoverBorder" = subtleBorder;
    "tab.unfocusedHoverBorder" = subtleBorder;
    "tab.unfocusedActiveBorder" = subtleBorder;
    "tab.unfocusedInactiveForeground" = textColors.disabled;
    "tab.activeModifiedBorder" = accent.primary;
    "tab.inactiveModifiedBorder" = accent.info;
  };

  editorColors = {
    "editor.background" = surfaces.base;
    "editor.foreground" = textColors.primary;
    "editorLineNumber.foreground" = textColors.disabled;
    "editorLineNumber.activeForeground" = textColors.primary;
    "editorCursor.foreground" = textColors.primary;
    "editorCursor.background" = surfaces.base;
    "editor.selectionBackground" = surfaces.selectionStrong;
    "editor.selectionHighlightBackground" = surfaces.selectionSoft;
    "editor.inactiveSelectionBackground" = surfaces.selectionSoft;
    "editor.wordHighlightBackground" = withAlpha accent.primary "26";
    "editor.wordHighlightStrongBackground" = withAlpha accent.primary "40";
    "editor.findMatchBackground" = withAlpha accent.warn "40";
    "editor.findMatchHighlightBackground" = withAlpha accent.warn "26";
    "editor.linkedEditingBackground" = withAlpha accent.primary "26";
    "editor.lineHighlightBackground" = lineHighlight;
    "editor.lineHighlightBorder" = subtleBorder;
    "editorWhitespace.foreground" = subtleBorder;
    "editorIndentGuide.background1" = subtleBorder;
    "editorIndentGuide.activeBackground1" = outlines.neutral;
    "editorRuler.foreground" = subtleBorder;
    "editorCodeLens.foreground" = textColors.secondary;
    "editor.selectionForeground" = textColors.primary;
    "editor.rangeHighlightBackground" = surfaces.selectionFaint;
    "editor.hoverHighlightBackground" = surfaces.selectionFaint;
    "editorBracketMatch.background" = withAlpha accent.primary "33";
    "editorBracketMatch.border" = outlines.focus;
    "editorBracketHighlight.foreground1" = base08;
    "editorBracketHighlight.foreground2" = base09;
    "editorBracketHighlight.foreground3" = base0A;
    "editorBracketHighlight.foreground4" = base0B;
    "editorBracketHighlight.foreground5" = base0D;
    "editorBracketHighlight.foreground6" = base0E;
    "editorBracketHighlight.unexpectedBracket.foreground" = accent.error;
    "editorGhostText.foreground" = ghostText;
    "editorHint.foreground" = accent.primary;
    "editorInlayHint.background" = withAlpha base01 "e6";
    "editorInlayHint.foreground" = textColors.secondary;
    "editorInlayHint.parameterBackground" = withAlpha base01 "e6";
    "editorInlayHint.parameterForeground" = textColors.secondary;
    "editorInlayHint.typeBackground" = withAlpha base01 "e6";
    "editorInlayHint.typeForeground" = textColors.secondary;
    "editor.foldBackground" = surfaces.selectionFaint;
  };

  editorWidgetColors = {
    "editorWidget.background" = surfaces.raised;
    "editorWidget.foreground" = textColors.primary;
    "editorWidget.border" = outlines.neutral;
    "editorWidget.resizeBorder" = outlines.focus;
    "editorSuggestWidget.background" = surfaces.raised;
    "editorSuggestWidget.border" = outlines.neutral;
    "editorSuggestWidget.foreground" = textColors.primary;
    "editorSuggestWidget.highlightForeground" = accent.primary;
    "editorSuggestWidget.selectedBackground" = surfaces.selectionStrong;
    "editorHoverWidget.background" = surfaces.raised;
    "editorHoverWidget.border" = outlines.neutral;
    "editorHoverWidget.foreground" = textColors.primary;
    "editorLightBulb.foreground" = accent.warn;
    "editorLightBulbAutoFix.foreground" = accent.success;
    "editorStickyScroll.background" = surfaces.raised;
    "editorStickyScrollHover.background" = surfaces.selectionSoft;
    "editorStickyScroll.border" = outlines.neutral;
  };

  diffAndGitColors = {
    "diffEditor.insertedTextBackground" = withAlpha accent.success "26";
    "diffEditor.insertedLineBackground" = withAlpha accent.success "1a";
    "diffEditor.removedTextBackground" = withAlpha accent.error "26";
    "diffEditor.removedLineBackground" = withAlpha accent.error "1a";
    "diffEditor.diagonalFill" = subtleBorder;
    "diffEditor.border" = outlines.neutral;
    "editorGutter.addedBackground" = accent.success;
    "editorGutter.deletedBackground" = accent.error;
    "editorGutter.modifiedBackground" = accent.secondary;
    "editorOverviewRuler.addedForeground" = withAlpha accent.success "cc";
    "editorOverviewRuler.deletedForeground" = withAlpha accent.error "cc";
    "editorOverviewRuler.modifiedForeground" = withAlpha accent.secondary "cc";
    "gitDecoration.addedResourceForeground" = accent.success;
    "gitDecoration.deletedResourceForeground" = accent.error;
    "gitDecoration.conflictingResourceForeground" = accent.urgent;
    "gitDecoration.modifiedResourceForeground" = accent.secondary;
    "gitDecoration.untrackedResourceForeground" = accent.warn;
    "gitDecoration.ignoredResourceForeground" = textColors.disabled;
    "gitDecoration.submoduleResourceForeground" = accent.info;
  };

  testingAndDiagnosticsColors = {
    "editorError.foreground" = accent.error;
    "editorWarning.foreground" = accent.warn;
    "editorInfo.foreground" = accent.info;
    "editorHint.border" = outlines.focus;
    "problemsErrorIcon.foreground" = accent.error;
    "problemsWarningIcon.foreground" = accent.warn;
    "problemsInfoIcon.foreground" = accent.info;
    "testing.runAction" = textColors.secondary;
    "testing.iconFailed" = accent.error;
    "testing.iconErrored" = accent.error;
    "testing.iconPassed" = accent.success;
    "testing.iconQueued" = accent.warn;
  };

  peekAndQuickInputColors = {
    "quickInput.background" = surfaces.raised;
    "quickInput.foreground" = textColors.primary;
    "quickInputList.focusBackground" = surfaces.selectionStrong;
    "quickInputList.focusForeground" = textColors.primary;
    "pickerGroup.border" = outlines.neutral;
    "pickerGroup.foreground" = textColors.secondary;
    "peekView.border" = outlines.focus;
    "peekViewEditor.background" = surfaces.base;
    "peekViewEditorGutter.background" = surfaces.base;
    "peekViewResult.background" = surfaces.raised;
    "peekViewResult.lineForeground" = textColors.secondary;
    "peekViewResult.matchHighlightBackground" = surfaces.selectionSoft;
    "peekViewTitle.background" = surfaces.raised;
    "peekViewTitleDescription.foreground" = textColors.secondary;
    "peekViewEditor.matchHighlightBackground" = surfaces.selectionSoft;
  };

  badgeAndProgressColors = {
    "badge.background" = accent.primary;
    "badge.foreground" = textColors.inverse;
    "progressBar.background" = accent.primary;
    "editorLink.activeForeground" = accent.primary;
  };

  terminalColors = {
    "terminal.background" = surfaces.base;
    "terminal.foreground" = textColors.primary;
    "terminal.selectionBackground" = surfaces.selectionStrong;
    "terminalCursor.foreground" = textColors.primary;
    "terminalCursor.background" = surfaces.base;
    "terminal.border" = outlines.neutral;
    "terminal.ansiBlack" = base00;
    "terminal.ansiRed" = base08;
    "terminal.ansiGreen" = base0B;
    "terminal.ansiYellow" = base0A;
    "terminal.ansiBlue" = base0D;
    "terminal.ansiMagenta" = base0E;
    "terminal.ansiCyan" = base0C;
    "terminal.ansiWhite" = base05;
    "terminal.ansiBrightBlack" = base03;
    "terminal.ansiBrightRed" = base08;
    "terminal.ansiBrightGreen" = base0B;
    "terminal.ansiBrightYellow" = base09;
    "terminal.ansiBrightBlue" = base0D;
    "terminal.ansiBrightMagenta" = base0E;
    "terminal.ansiBrightCyan" = base0C;
    "terminal.ansiBrightWhite" = base07;
  };

  scrollbarColors = {
    "scrollbar.shadow" = shadow;
    "scrollbarSlider.background" = withAlpha base04 "40";
    "scrollbarSlider.hoverBackground" = withAlpha base04 "66";
    "scrollbarSlider.activeBackground" = withAlpha base04 "80";
  };

  overviewRulerColors = {
    "editorOverviewRuler.background" = withAlpha base01 "80";
  };
in
{
  "$schema" = "vscode://schemas/color-theme";
  name = "Stylix";
  type = themeType;
  colors = mergeSets [
    baseColors
    windowColors
    navigationColors
    statusAndNotificationColors
    buttonAndInputColors
    listAndTreeColors
    tabsAndEditorGroupColors
    editorColors
    editorWidgetColors
    diffAndGitColors
    testingAndDiagnosticsColors
    peekAndQuickInputColors
    badgeAndProgressColors
    terminalColors
    scrollbarColors
    overviewRulerColors
  ];

  tokenColors = [
    {
      name = "Comments";
      scope = [
        "comment"
        "punctuation.definition.comment"
      ];
      settings = {
        fontStyle = "italic";
        foreground = base03;
      };
    }
    {
      name = "Variables";
      scope = [
        "variable"
        "variable.other"
        "entity.name.variable"
      ];
      settings.foreground = base05;
    }
    {
      name = "Parameters";
      scope = [
        "variable.parameter"
        "meta.parameter"
      ];
      settings = {
        foreground = base05;
        fontStyle = "italic";
      };
    }
    {
      name = "Constants & Numbers";
      scope = [
        "constant"
        "constant.numeric"
        "constant.language"
        "constant.character"
        "constant.other.symbol"
      ];
      settings.foreground = base09;
    }
    {
      name = "Strings";
      scope = [
        "string"
        "string.template"
        "meta.embedded.assembly"
      ];
      settings.foreground = base0B;
    }
    {
      name = "Keywords & Storage";
      scope = [
        "keyword"
        "storage"
        "keyword.operator.new"
      ];
      settings.foreground = base0E;
    }
    {
      name = "Types & Classes";
      scope = [
        "entity.name.type"
        "entity.name.class"
        "storage.type"
        "support.type"
      ];
      settings.foreground = base0A;
    }
    {
      name = "Functions & Methods";
      scope = [
        "entity.name.function"
        "meta.function-call"
        "support.function"
        "variable.function"
      ];
      settings.foreground = base0D;
    }
    {
      name = "Properties";
      scope = [
        "variable.other.object.property"
        "support.variable.property"
      ];
      settings.foreground = base0C;
    }
    {
      name = "Operators & Punctuation";
      scope = [
        "keyword.operator"
        "punctuation"
        "meta.brace"
      ];
      settings.foreground = base05;
    }
    {
      name = "Decorators & Attributes";
      scope = [
        "entity.name.tag"
        "entity.other.attribute-name"
        "meta.decorator"
      ];
      settings = {
        foreground = base0E;
        fontStyle = "italic";
      };
    }
    {
      name = "Invalid";
      scope = [
        "invalid"
        "invalid.illegal"
      ];
      settings = {
        foreground = base00;
        # background = base08; Not currently supported
      };
    }
    {
      name = "Markup Headings";
      scope = [
        "markup.heading"
        "entity.name.section"
      ];
      settings = {
        foreground = base0D;
        fontStyle = "bold";
      };
    }
    {
      name = "Markup Bold";
      scope = [ "markup.bold" ];
      settings = {
        foreground = base0E;
        fontStyle = "bold";
      };
    }
    {
      name = "Markup Italic";
      scope = [ "markup.italic" ];
      settings = {
        foreground = base0E;
        fontStyle = "italic";
      };
    }
    {
      name = "Markup Quote";
      scope = [ "markup.quote" ];
      settings.foreground = base0C;
    }
    {
      name = "Markup Link";
      scope = [
        "markup.underline.link"
        "string.other.link"
      ];
      settings = {
        foreground = base0D;
        fontStyle = "underline";
      };
    }
    {
      name = "Diff Inserted";
      scope = [ "markup.inserted" ];
      settings.foreground = base0B;
    }
    {
      name = "Diff Deleted";
      scope = [ "markup.deleted" ];
      settings.foreground = base08;
    }
    {
      name = "Diff Changed";
      scope = [ "markup.changed" ];
      settings.foreground = base0E;
    }
    {
      name = "Inline Code";
      scope = [
        "markup.inline.raw"
        "markup.raw.block"
      ];
      settings.foreground = base0C;
    }
  ];

  semanticHighlighting = true;
  semanticTokenColors = {
    "comment" = base03;
    "string" = base0B;
    "keyword" = base0E;
    "number" = base09;
    "operator" = base05;
    "regexp" = base0C;
    "type" = base0A;
    "class" = base0A;
    "struct" = base0A;
    "interface" = base0A;
    "enum" = base09;
    "enumMember" = base09;
    "function" = base0D;
    "method" = base0D;
    "macro" = base0F;
    "variable" = base05;
    "variable.readonly" = base09;
    "variable.constant" = base09;
    "property" = base0C;
    "parameter" = base05;
    "decorator" = {
      foreground = base0E;
      fontStyle = "italic";
    };
    "*.declaration" = {
      foreground = base0D;
      fontStyle = "bold";
    };
    "*.deprecated" = {
      foreground = base0F;
      fontStyle = "strikethrough";
    };
  };
}
