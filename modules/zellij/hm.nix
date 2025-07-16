{ mkTarget, ... }:
mkTarget {
  name = "zellij";
  humanName = "zellij";

  configElements =
    { colors }:
    {
      programs.zellij.themes.stylix = {
        themes = with colors.withHashtag; {
          default = {
            text_unselected = {
              base = base05;
              background = base01;
              emphasis_0 = base09;
              emphasis_1 = base0C;
              emphasis_2 = base0B;
              emphasis_3 = base0F;
            };
            text_selected = {
              base = base05;
              background = base04;
              emphasis_0 = base09;
              emphasis_1 = base0C;
              emphasis_2 = base0B;
              emphasis_3 = base0F;
            };
            ribbon_selected = {
              base = base01;
              background = base0E;
              emphasis_0 = base08;
              emphasis_1 = base09;
              emphasis_2 = base0F;
              emphasis_3 = base0D;
            };
            ribbon_unselected = {
              base = base01;
              background = base05;
              emphasis_0 = base08;
              emphasis_1 = base05;
              emphasis_2 = base0D;
              emphasis_3 = base0F;
            };
            table_title = {
              base = base0E;
              background = base00;
              emphasis_0 = base09;
              emphasis_1 = base0C;
              emphasis_2 = base0B;
              emphasis_3 = base0F;
            };
            table_cell_selected = {
              base = base05;
              background = base04;
              emphasis_0 = base09;
              emphasis_1 = base0C;
              emphasis_2 = base0B;
              emphasis_3 = base0F;
            };
            table_cell_unselected = {
              base = base05;
              background = base01;
              emphasis_0 = base09;
              emphasis_1 = base0C;
              emphasis_2 = base0B;
              emphasis_3 = base0F;
            };
            list_selected = {
              base = base05;
              background = base04;
              emphasis_0 = base09;
              emphasis_1 = base0C;
              emphasis_2 = base0B;
              emphasis_3 = base0F;
            };
            list_unselected = {
              base = base05;
              background = base01;
              emphasis_0 = base09;
              emphasis_1 = base0C;
              emphasis_2 = base0B;
              emphasis_3 = base0F;
            };
            frame_selected = {
              base = base0E;
              background = base00;
              emphasis_0 = base09;
              emphasis_1 = base0C;
              emphasis_2 = base0F;
              emphasis_3 = base00;
            };
            frame_highlight = {
              base = base08;
              background = base00;
              emphasis_0 = base0F;
              emphasis_1 = base09;
              emphasis_2 = base09;
              emphasis_3 = base09;
            };
            exit_code_success = {
              base = base0B;
              background = base00;
              emphasis_0 = base0C;
              emphasis_1 = base01;
              emphasis_2 = base0F;
              emphasis_3 = base0D;
            };
            exit_code_error = {
              base = base08;
              background = base00;
              emphasis_0 = base0A;
              emphasis_1 = base00;
              emphasis_2 = base00;
              emphasis_3 = base00;
            };
            multiplayer_user_colors = {
              player_1 = base0F;
              player_2 = base0D;
              player_3 = base00;
              player_4 = base0A;
              player_5 = base0C;
              player_6 = base00;
              player_7 = base08;
              player_8 = base00;
              player_9 = base00;
              player_10 = base00;
            };
          };
        };
      };
    };
}
