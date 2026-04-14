{ mkTarget, lib, ... }:
mkTarget {
  config = [
    (
      { colors }:
      with colors;
      {
        programs.wezterm.colorSchemes.stylix = {
          ansi = [
            base00
            base08
            base0B
            base0A
            base0D
            base0E
            base0C
            base05
          ];
          brights = [
            base03
            base08
            base0B
            base0A
            base0D
            base0E
            base0C
            base07
          ];
          background = base00;
          cursor_bg = base05;
          cursor_fg = base00;
          compose_cursor = base06;
          foreground = base05;
          scrollbar_thumb = base01;
          selection_bg = base05;
          selection_fg = base00;
          split = base03;
          visual_bell = base09;
          tab_bar = {
            background = base01;
            inactive_tab_edge = base01;
            active_tab = {
              bg_color = base00;
              fg_color = base05;
            };
            inactive_tab = {
              bg_color = base03;
              fg_color = base05;
            };
            inactive_tab_hover = {
              bg_color = base05;
              fg_color = base00;
            };
            new_tab = {
              bg_color = base03;
              fg_color = base05;
            };
            new_tab_hover = {
              bg_color = base05;
              fg_color = base00;
            };
          };
        };
        programs.wezterm.settings = {
          color_scheme = "stylix";
          window_frame = {
            active_titlebar_bg = base03;
            active_titlebar_fg = base05;
            active_titlebar_border_bottom = base03;
            border_left_color = base01;
            border_right_color = base01;
            border_bottom_color = base01;
            border_top_color = base01;
            button_bg = base01;
            button_fg = base05;
            button_hover_bg = base05;
            button_hover_fg = base03;
            inactive_titlebar_bg = base01;
            inactive_titlebar_fg = base05;
            inactive_titlebar_border_bottom = base03;
          };
          colors = {
            tab_bar = {
              background = base01;
              inactive_tab_edge = base01;
              active_tab = {
                bg_color = base00;
                fg_color = base05;
              };
              inactive_tab = {
                bg_color = base03;
                fg_color = base05;
              };
              inactive_tab_hover = {
                bg_color = base05;
                fg_color = base00;
              };
              new_tab = {
                bg_color = base03;
                fg_color = base05;
              };
              new_tab_hover = {
                bg_color = base05;
                fg_color = base00;
              };
            };
          };
          command_palette_bg_color = base01;
          command_palette_fg_color = base05;
        };
      }
    )
    (
      { fonts }:
      {
        programs.wezterm.settings = {
          font = lib.generators.mkLuaInline ''wezterm.font_with_fallback { "${fonts.monospace.name}", "${fonts.emoji.name}" }'';
          font_size = fonts.sizes.terminal;
          command_palette_font_size = fonts.sizes.popups;
        };
      }
    )
    (
      { opacity }:
      {
        programs.wezterm.settings.window_background_opacity = opacity.terminal;
      }
    )
  ];
}
