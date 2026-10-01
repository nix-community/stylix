fonts: with fonts; {
  "workbench.colorTheme" = "Stylix";
  "editor.fontFamily" = monospace.name;
  "editor.inlayHints.fontFamily" = monospace.name;
  "editor.inlineSuggest.fontFamily" = monospace.name;
  "scm.inputFontFamily" = monospace.name;
  "debug.console.fontFamily" = monospace.name;
  "markdown.preview.fontFamily" = sansSerif.name;
  "chat.editor.fontFamily" = monospace.name;
  "chat.fontFamily" = sansSerif.name;
  "notebook.markup.fontFamily" = sansSerif.name;

  "editor.fontSize" = sizes.terminal.px;
  "debug.console.fontSize" = sizes.terminal.px;
  "markdown.preview.fontSize" = sizes.terminal.px;
  "terminal.integrated.fontSize" = sizes.terminal.px;
  "chat.editor.fontSize" = sizes.terminal.px;

  # other factors (9/14, 13/14, 56/14) based on default for given value
  # divided by default for `editor.fontSize` (14) from
  # https://code.visualstudio.com/docs/getstarted/settings#_default-settings.
  "editor.minimap.sectionHeaderFontSize" = sizes.terminal.px * 9.0 / 14.0;
  "scm.inputFontSize" = sizes.terminal.px * 13.0 / 14.0;
  "screencastMode.fontSize" = sizes.terminal.px * 56.0 / 14.0;
}
