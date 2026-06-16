# Documentation is available at:
# - https://github.com/alexpasmantier/television
# - `man television`
{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      programs.television = {
        settings.ui.theme = "stylix";
        themes.stylix = with colors.withHashtag; {
          background = base00;
          border_fg = base03;
          text_fg = base05;
          dimmed_text_fg = base04;
          input_text_fg = base05;
          result_count_fg = base03;
          result_name_fg = base0D;
          result_line_number_fg = base03;
          result_value_fg = base05;
          selection_bg = base02;
          selection_fg = base05;
          match_fg = base0A;
          preview_title_fg = base0E;
          channel_mode_fg = base0B;
          channel_mode_bg = base00;
          remote_control_mode_fg = base0C;
          remote_control_mode_bg = base00;
        };
      };
    };
}
