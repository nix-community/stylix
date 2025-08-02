{
  config,
  lib,
  mkTarget,
  pkgs,
  ...
}:
mkTarget {
  name = "anki";
  humanName = "Anki";

  configElements =
    { colors }:
    {
      programs.anki.addons = lib.singleton (
        pkgs.ankiAddons.recolor.withConfig {
          config = {
            version = {
              major = 3;
              minor = 1;
            };
            colors = {
              ACCENT_CARD = [
                "Card mode"
                colors.withHashtag.base0D
                colors.withHashtag.base0D
                "--accent-card"
              ];
              ACCENT_DANGER = [
                "Danger"
                colors.withHashtag.base08
                colors.withHashtag.base08
                "--accent-danger"
              ];
              ACCENT_NOTE = [
                "Note mode"
                colors.withHashtag.base0B
                colors.withHashtag.base0B
                "--accent-note"
              ];
              BORDER = [
                "Border"
                colors.withHashtag.base04
                colors.withHashtag.base04
                "--border"
              ];
              BORDER_FOCUS = [
                "Border (focused input)"
                colors.withHashtag.base0D
                colors.withHashtag.base0D
                "--border-focus"
              ];
              BORDER_STRONG = [
                "Border (strong)"
                colors.withHashtag.base03
                colors.withHashtag.base03
                "--border-strong"
              ];
              BORDER_SUBTLE = [
                "Border (subtle)"
                colors.withHashtag.base07
                colors.withHashtag.base07
                "--border-subtle"
              ];
              BUTTON_BG = [
                "Button background"
                colors.withHashtag.base01
                colors.withHashtag.base01
                "--button-bg"
              ];
              BUTTON_DISABLED = [
                "Button background (disabled)"
                "${colors.withHashtag.base01}80"
                "${colors.withHashtag.base01}80"
                "--button-disabled"
              ];
              BUTTON_HOVER = [
                "Button background (hover)"
                colors.withHashtag.base02
                colors.withHashtag.base02
                [
                  "--button-gradient-start"
                  "--button-gradient-end"
                ]
              ];
              BUTTON_HOVER_BORDER = [
                "Button border (hover)"
                colors.withHashtag.base01
                colors.withHashtag.base01
                "--button-hover-border"
              ];
              BUTTON_PRIMARY_BG = [
                "Button Primary Bg"
                colors.withHashtag.base0D
                colors.withHashtag.base0D
                "--button-primary-bg"
              ];
              BUTTON_PRIMARY_DISABLED = [
                "Button Primary Disabled"
                "${colors.withHashtag.base0D}80"
                "${colors.withHashtag.base0D}80"
                "--button-primary-disabled"
              ];
              BUTTON_PRIMARY_GRADIENT_END = [
                "Button Primary Gradient End"
                colors.withHashtag.base0D
                colors.withHashtag.base0D
                "--button-primary-gradient-end"
              ];
              BUTTON_PRIMARY_GRADIENT_START = [
                "Button Primary Gradient Start"
                colors.withHashtag.base0D
                colors.withHashtag.base0D
                "--button-primary-gradient-start"
              ];
              CANVAS = [
                "Background"
                colors.withHashtag.base00
                colors.withHashtag.base00
                [
                  "--canvas"
                  "--bs-body-bg"
                ]
              ];
              CANVAS_CODE = [
                "Code editor background"
                colors.withHashtag.base00
                colors.withHashtag.base00
                "--canvas-code"
              ];
              CANVAS_ELEVATED = [
                "Background (elevated)"
                colors.withHashtag.base01
                colors.withHashtag.base01
                "--canvas-elevated"
              ];
              CANVAS_GLASS = [
                "Background (transparent text surface)"
                "${colors.withHashtag.base01}66"
                "${colors.withHashtag.base01}66"
                "--canvas-glass"
              ];
              CANVAS_INSET = [
                "Background (inset)"
                colors.withHashtag.base01
                colors.withHashtag.base01
                "--canvas-inset"
              ];
              CANVAS_OVERLAY = [
                "Background (menu & tooltip)"
                colors.withHashtag.base02
                colors.withHashtag.base02
                "--canvas-overlay"
              ];
              FG = [
                "Text"
                colors.withHashtag.base05
                colors.withHashtag.base05
                [
                  "--fg"
                  "--bs-body-color"
                ]
              ];
              FG_DISABLED = [
                "Text (disabled)"
                colors.withHashtag.base03
                colors.withHashtag.base03
                "--fg-disabled"
              ];
              FG_FAINT = [
                "Text (faint)"
                colors.withHashtag.base04
                colors.withHashtag.base04
                "--fg-faint"
              ];
              FG_LINK = [
                "Text (link)"
                colors.withHashtag.base0D
                colors.withHashtag.base0D
                "--fg-link"
              ];
              FG_SUBTLE = [
                "Text (subtle)"
                colors.withHashtag.base03
                colors.withHashtag.base03
                "--fg-subtle"
              ];

              FLAG_1 = [
                "Flag 1"
                colors.withHashtag.base08
                colors.withHashtag.base08
                "--flag-1"
              ];
              FLAG_2 = [
                "Flag 2"
                colors.withHashtag.base09
                colors.withHashtag.base09
                "--flag-2"
              ];
              FLAG_3 = [
                "Flag 3"
                colors.withHashtag.base0A
                colors.withHashtag.base0A
                "--flag-3"
              ];
              FLAG_4 = [
                "Flag 4"
                colors.withHashtag.base0B
                colors.withHashtag.base0B
                "--flag-4"
              ];
              FLAG_5 = [
                "Flag 5"
                colors.withHashtag.base0C
                colors.withHashtag.base0C
                "--flag-5"
              ];
              FLAG_6 = [
                "Flag 6"
                colors.withHashtag.base0D
                colors.withHashtag.base0D
                "--flag-6"
              ];
              FLAG_7 = [
                "Flag 7"
                colors.withHashtag.base0E
                colors.withHashtag.base0E
                "--flag-7"
              ];

              HIGHLIGHT_BG = [
                "Highlight background"
                "${colors.withHashtag.base02}80"
                "${colors.withHashtag.base02}80"
                "--highlight-bg"
              ];
              HIGHLIGHT_FG = [
                "Highlight text"
                colors.withHashtag.base05
                colors.withHashtag.base05
                "--highlight-fg"
              ];
              SCROLLBAR_BG = [
                "Scrollbar background"
                colors.withHashtag.base03
                colors.withHashtag.base03
                "--scrollbar-bg"
              ];
              SCROLLBAR_BG_ACTIVE = [
                "Scrollbar background (active)"
                colors.withHashtag.base06
                colors.withHashtag.base06
                "--scrollbar-bg-active"
              ];
              SCROLLBAR_BG_HOVER = [
                "Scrollbar background (hover)"
                colors.withHashtag.base07
                colors.withHashtag.base07
                "--scrollbar-bg-hover"
              ];
              SELECTED_BG = [
                "Selected Bg"
                colors.withHashtag.base02
                colors.withHashtag.base02
                "--selected-bg"
              ];
              SELECTED_FG = [
                "Selected Fg"
                colors.withHashtag.base05
                colors.withHashtag.base05
                "--selected-fg"
              ];
              SHADOW = [
                "Shadow"
                colors.withHashtag.base01
                colors.withHashtag.base01
                "--shadow"
              ];
              SHADOW_FOCUS = [
                "Shadow (focused input)"
                colors.withHashtag.base0D
                colors.withHashtag.base0D
                "--shadow-focus"
              ];
              SHADOW_INSET = [
                "Shadow (inset)"
                colors.withHashtag.base01
                colors.withHashtag.base01
                "--shadow-inset"
              ];
              SHADOW_SUBTLE = [
                "Shadow (subtle)"
                colors.withHashtag.base01
                colors.withHashtag.base01
                "--shadow-subtle"
              ];
              STATE_BURIED = [
                "Buried"
                colors.withHashtag.base09
                colors.withHashtag.base09
                "--state-buried"
              ];
              STATE_LEARN = [
                "Learn"
                colors.withHashtag.base08
                colors.withHashtag.base08
                "--state-learn"
              ];
              STATE_MARKED = [
                "Marked"
                colors.withHashtag.base0E
                colors.withHashtag.base0E
                "--state-marked"
              ];
              STATE_NEW = [
                "New"
                colors.withHashtag.base0D
                colors.withHashtag.base0D
                "--state-new"
              ];
              STATE_REVIEW = [
                "Review"
                colors.withHashtag.base0B
                colors.withHashtag.base0B
                "--state-review"
              ];
              STATE_SUSPENDED = [
                "Suspended"
                colors.withHashtag.base0A
                colors.withHashtag.base0A
                "--state-suspended"
              ];
            };
          };
        }
      );
    };
}
