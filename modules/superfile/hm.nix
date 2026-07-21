{ mkTarget, ... }:
mkTarget {
  config = [
    (
      { colors, ... }:
      {
        programs.superfile =
          let
            theme = "stylix";
          in
          {
            settings.theme = "stylix";
            themes.${theme} = {
              code_syntax_highlight = "stylix";
              full_screen_fg = colors.withHashtag.base05;
              full_screen_bg = colors.withHashtag.base00;
              gradient_color = [
                colors.withHashtag.base0D
                colors.withHashtag.base0E
              ];
              file_panel_fg = colors.withHashtag.base05;
              file_panel_bg = colors.withHashtag.base00;
              file_panel_border = colors.withHashtag.base03;
              file_panel_border_active = colors.withHashtag.base16;
              file_panel_top_directory_icon = colors.withHashtag.base14;
              file_panel_top_path = colors.withHashtag.base0D;
              file_panel_item_selected_fg = colors.withHashtag.base0D;
              file_panel_item_selected_bg = colors.withHashtag.base00;
              footer_fg = colors.withHashtag.base09;
              footer_bg = colors.withHashtag.base00;
              footer_border = colors.withHashtag.base03;
              footer_border_active = colors.withHashtag.base16;
              sidebar_fg = colors.withHashtag.base05;
              sidebar_bg = colors.withHashtag.base00;
              sidebar_title = colors.withHashtag.base14;
              sidebar_border = colors.withHashtag.base03;
              sidebar_border_active = colors.withHashtag.base0F;
              sidebar_item_selected_fg = colors.withHashtag.base15;
              sidebar_item_selected_bg = colors.withHashtag.base00;
              sidebar_divider = colors.withHashtag.base03;
              modal_fg = colors.withHashtag.base05;
              modal_bg = colors.withHashtag.base00;
              modal_border_active = colors.withHashtag.base14;
              modal_cancel_fg = colors.withHashtag.base11;
              modal_cancel_bg = colors.withHashtag.base13;
              modal_confirm_fg = colors.withHashtag.base11;
              modal_confirm_bg = colors.withHashtag.base14;
              help_menu_hotkey = colors.withHashtag.base15;
              help_menu_title = colors.withHashtag.base14;
              cursor = colors.withHashtag.base13;
              correct = colors.withHashtag.base0B;
              error = colors.withHashtag.base0F;
              hint = colors.withHashtag.base15;
              cancel = colors.withHashtag.base13;
            };
          };
      }
    )
  ];
}
