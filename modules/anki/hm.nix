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
  autoEnable = config.programs.anki.enable;
  autoEnableExpr = "programs.anki.enable";

  configElements = lib.singleton (
    { colors }:
    {
      programs.anki.addons = [
        (
          with colors.withHashtag;
          pkgs.ankiAddons.recolor.withConfig {
            config = {
              colors = {
                ACCENT_CARD = [
                  "Card mode"
                  "${base0D}"
                  "${base0D}"
                  "--accent-card"
                ];
                ACCENT_DANGER = [
                  "Danger"
                  "${base08}"
                  "${base08}"
                  "--accent-danger"
                ];
                ACCENT_NOTE = [
                  "Note mode"
                  "${base0B}"
                  "${base0B}"
                  "--accent-note"
                ];
                BORDER = [
                  "Border"
                  "${base04}"
                  "${base04}"
                  "--border"
                ];
                BORDER_FOCUS = [
                  "Border (focused input)"
                  "${base0D}"
                  "${base0D}"
                  "--border-focus"
                ];
                BORDER_STRONG = [
                  "Border (strong)"
                  "${base03}"
                  "${base03}"
                  "--border-strong"
                ];
                BORDER_SUBTLE = [
                  "Border (subtle)"
                  "${base07}"
                  "${base07}"
                  "--border-subtle"
                ];
                BUTTON_BG = [
                  "Button background"
                  "${base01}"
                  "${base01}"
                  "--button-bg"
                ];
                BUTTON_DISABLED = [
                  "Button background (disabled)"
                  "${base01}80"
                  "${base01}80"
                  "--button-disabled"
                ];
                BUTTON_HOVER = [
                  "Button background (hover)"
                  "${base02}"
                  "${base02}"
                  [
                    "--button-gradient-start"
                    "--button-gradient-end"
                  ]
                ];
                BUTTON_HOVER_BORDER = [
                  "Button border (hover)"
                  "${base01}"
                  "${base01}"
                  "--button-hover-border"
                ];
                BUTTON_PRIMARY_BG = [
                  "Button Primary Bg"
                  "${base0D}"
                  "${base0D}"
                  "--button-primary-bg"
                ];
                BUTTON_PRIMARY_DISABLED = [
                  "Button Primary Disabled"
                  "${base0D}80"
                  "${base0D}80"
                  "--button-primary-disabled"
                ];
                BUTTON_PRIMARY_GRADIENT_END = [
                  "Button Primary Gradient End"
                  "${base0D}"
                  "${base0D}"
                  "--button-primary-gradient-end"
                ];
                BUTTON_PRIMARY_GRADIENT_START = [
                  "Button Primary Gradient Start"
                  "${base0D}"
                  "${base0D}"
                  "--button-primary-gradient-start"
                ];
                CANVAS = [
                  "Background"
                  "${base00}"
                  "${base00}"
                  [
                    "--canvas"
                    "--bs-body-bg"
                  ]
                ];
                CANVAS_CODE = [
                  "Code editor background"
                  "${base00}"
                  "${base00}"
                  "--canvas-code"
                ];
                CANVAS_ELEVATED = [
                  "Background (elevated)"
                  "${base01}"
                  "${base01}"
                  "--canvas-elevated"
                ];
                CANVAS_GLASS = [
                  "Background (transparent text surface)"
                  "${base01}66"
                  "${base01}66"
                  "--canvas-glass"
                ];
                CANVAS_INSET = [
                  "Background (inset)"
                  "${base01}"
                  "${base01}"
                  "--canvas-inset"
                ];
                CANVAS_OVERLAY = [
                  "Background (menu & tooltip)"
                  "${base02}"
                  "${base02}"
                  "--canvas-overlay"
                ];
                FG = [
                  "Text"
                  "${base05}"
                  "${base05}"
                  [
                    "--fg"
                    "--bs-body-color"
                  ]
                ];
                FG_DISABLED = [
                  "Text (disabled)"
                  "${base03}"
                  "${base03}"
                  "--fg-disabled"
                ];
                FG_FAINT = [
                  "Text (faint)"
                  "${base04}"
                  "${base04}"
                  "--fg-faint"
                ];
                FG_LINK = [
                  "Text (link)"
                  "${base0D}"
                  "${base0D}"
                  "--fg-link"
                ];
                FG_SUBTLE = [
                  "Text (subtle)"
                  "${base03}"
                  "${base03}"
                  "--fg-subtle"
                ];

                FLAG_1 = [
                  "Flag 1"
                  "${base08}"
                  "${base08}"
                  "--flag-1"
                ];
                FLAG_2 = [
                  "Flag 2"
                  "${base09}"
                  "${base09}"
                  "--flag-2"
                ];
                FLAG_3 = [
                  "Flag 3"
                  "${base0A}"
                  "${base0A}"
                  "--flag-3"
                ];
                FLAG_4 = [
                  "Flag 4"
                  "${base0B}"
                  "${base0B}"
                  "--flag-4"
                ];
                FLAG_5 = [
                  "Flag 5"
                  "${base0C}"
                  "${base0C}"
                  "--flag-5"
                ];
                FLAG_6 = [
                  "Flag 6"
                  "${base0D}"
                  "${base0D}"
                  "--flag-6"
                ];
                FLAG_7 = [
                  "Flag 7"
                  "${base0E}"
                  "${base0E}"
                  "--flag-7"
                ];

                HIGHLIGHT_BG = [
                  "Highlight background"
                  "${base02}80"
                  "${base02}80"
                  "--highlight-bg"
                ];
                HIGHLIGHT_FG = [
                  "Highlight text"
                  "${base05}"
                  "${base05}"
                  "--highlight-fg"
                ];
                SCROLLBAR_BG = [
                  "Scrollbar background"
                  "${base03}"
                  "${base03}"
                  "--scrollbar-bg"
                ];
                SCROLLBAR_BG_ACTIVE = [
                  "Scrollbar background (active)"
                  "${base06}"
                  "${base06}"
                  "--scrollbar-bg-active"
                ];
                SCROLLBAR_BG_HOVER = [
                  "Scrollbar background (hover)"
                  "${base07}"
                  "${base07}"
                  "--scrollbar-bg-hover"
                ];
                SELECTED_BG = [
                  "Selected Bg"
                  "${base02}"
                  "${base02}"
                  "--selected-bg"
                ];
                SELECTED_FG = [
                  "Selected Fg"
                  "${base05}"
                  "${base05}"
                  "--selected-fg"
                ];
                SHADOW = [
                  "Shadow"
                  "${base01}"
                  "${base01}"
                  "--shadow"
                ];
                SHADOW_FOCUS = [
                  "Shadow (focused input)"
                  "${base0D}"
                  "${base0D}"
                  "--shadow-focus"
                ];
                SHADOW_INSET = [
                  "Shadow (inset)"
                  "${base01}"
                  "${base01}"
                  "--shadow-inset"
                ];
                SHADOW_SUBTLE = [
                  "Shadow (subtle)"
                  "${base01}"
                  "${base01}"
                  "--shadow-subtle"
                ];
                STATE_BURIED = [
                  "Buried"
                  "${base09}"
                  "${base09}"
                  "--state-buried"
                ];
                STATE_LEARN = [
                  "Learn"
                  "${base08}"
                  "${base08}"
                  "--state-learn"
                ];
                STATE_MARKED = [
                  "Marked"
                  "${base0E}"
                  "${base0E}"
                  "--state-marked"
                ];
                STATE_NEW = [
                  "New"
                  "${base0D}"
                  "${base0D}"
                  "--state-new"
                ];
                STATE_REVIEW = [
                  "Review"
                  "${base0B}"
                  "${base0B}"
                  "--state-review"
                ];
                STATE_SUSPENDED = [
                  "Suspended"
                  "${base0A}"
                  "${base0A}"
                  "--state-suspended"
                ];
              };

              version = {
                major = 3;
                minor = 1;
              };
            };

          }
        )
      ];
    }
  );
}
