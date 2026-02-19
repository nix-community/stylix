{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      programs.sioyek.config = with colors.withHashtag; {
        startup_commands = "toggle_custom_color";
        background_color = base00;
        text_highlight_color = base0A;
        visual_mark_color = base02;
        search_highlight_color = base0A;
        link_highlight_color = base0D;
        synctex_highlight_color = base0B;
        highlight_color_a = base0A;
        highlight_color_b = base0B;
        highlight_color_c = base0D;
        highlight_color_d = base08;
        highlight_color_e = base0E;
        highlight_color_f = base09;
        highlight_color_g = base0A;
        custom_background_color = base00;
        custom_text_color = base05;
        ui_text_color = base05;
        ui_background_color = base01;
        ui_selected_text_color = base05;
        ui_selected_background_color = base02;
        status_bar_color = base01;
        status_bar_text_color = base05;
      };
    };
}
