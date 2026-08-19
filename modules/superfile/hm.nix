{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    let
      theme = "stylix";
    in
    {
      programs.superfile = {
        settings = { inherit theme; };
        themes.${theme} = with colors.withHashtag; {
          code_syntax_highlight = theme;
          full_screen_fg = base05;
          full_screen_bg = base00;
          gradient_color = [ base0E ];
          file_panel_fg = base05;
          file_panel_bg = base00;
          file_panel_border = base03;
          file_panel_border_active = base16;
          file_panel_top_directory_icon = base14;
          file_panel_top_path = base0D;
          file_panel_item_selected_fg = base0D;
          file_panel_item_selected_bg = base00;
          footer_fg = base09;
          footer_bg = base00;
          footer_border = base03;
          footer_border_active = base16;
          sidebar_fg = base05;
          sidebar_bg = base00;
          sidebar_title = base14;
          sidebar_border = base03;
          sidebar_border_active = base0F;
          sidebar_item_selected_fg = base15;
          sidebar_item_selected_bg = base00;
          sidebar_divider = base03;
          modal_fg = base05;
          modal_bg = base00;
          modal_border_active = base14;
          modal_cancel_fg = base11;
          modal_cancel_bg = base13;
          modal_confirm_fg = base11;
          modal_confirm_bg = base14;
          help_menu_hotkey = base15;
          help_menu_title = base14;
          cursor = base13;
          correct = base0B;
          error = base0F;
          hint = base15;
          cancel = base13;
        };
      };
    };
}
