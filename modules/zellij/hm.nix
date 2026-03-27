{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    let
      # makes an array of the rgb components, parsing them as numbers
      mkColorTriple =
        name:
        (map (color: builtins.fromJSON colors."${name}-rgb-${color}") [
          "r"
          "g"
          "b"
        ]);
    in
    {
      programs.zellij.themes.stylix = {
        themes = {
          default = {
            text_unselected = {
              base = mkColorTriple "base05";
              background = mkColorTriple "base01";
              emphasis_0 = mkColorTriple "base09";
              emphasis_1 = mkColorTriple "base0C";
              emphasis_2 = mkColorTriple "base0B";
              emphasis_3 = mkColorTriple "base0F";
            };
            text_selected = {
              base = mkColorTriple "base05";
              background = mkColorTriple "base04";
              emphasis_0 = mkColorTriple "base09";
              emphasis_1 = mkColorTriple "base0C";
              emphasis_2 = mkColorTriple "base0B";
              emphasis_3 = mkColorTriple "base0F";
            };
            ribbon_selected = {
              base = mkColorTriple "base01";
              background = mkColorTriple "base0E";
              emphasis_0 = mkColorTriple "base08";
              emphasis_1 = mkColorTriple "base09";
              emphasis_2 = mkColorTriple "base0F";
              emphasis_3 = mkColorTriple "base0D";
            };
            ribbon_unselected = {
              base = mkColorTriple "base01";
              background = mkColorTriple "base05";
              emphasis_0 = mkColorTriple "base08";
              emphasis_1 = mkColorTriple "base05";
              emphasis_2 = mkColorTriple "base0D";
              emphasis_3 = mkColorTriple "base0F";
            };
            table_title = {
              base = mkColorTriple "base0E";
              background = mkColorTriple "base00";
              emphasis_0 = mkColorTriple "base09";
              emphasis_1 = mkColorTriple "base0C";
              emphasis_2 = mkColorTriple "base0B";
              emphasis_3 = mkColorTriple "base0F";
            };
            table_cell_selected = {
              base = mkColorTriple "base05";
              background = mkColorTriple "base04";
              emphasis_0 = mkColorTriple "base09";
              emphasis_1 = mkColorTriple "base0C";
              emphasis_2 = mkColorTriple "base0B";
              emphasis_3 = mkColorTriple "base0F";
            };
            table_cell_unselected = {
              base = mkColorTriple "base05";
              background = mkColorTriple "base01";
              emphasis_0 = mkColorTriple "base09";
              emphasis_1 = mkColorTriple "base0C";
              emphasis_2 = mkColorTriple "base0B";
              emphasis_3 = mkColorTriple "base0F";
            };
            list_selected = {
              base = mkColorTriple "base05";
              background = mkColorTriple "base04";
              emphasis_0 = mkColorTriple "base09";
              emphasis_1 = mkColorTriple "base0C";
              emphasis_2 = mkColorTriple "base0B";
              emphasis_3 = mkColorTriple "base0F";
            };
            list_unselected = {
              base = mkColorTriple "base05";
              background = mkColorTriple "base01";
              emphasis_0 = mkColorTriple "base09";
              emphasis_1 = mkColorTriple "base0C";
              emphasis_2 = mkColorTriple "base0B";
              emphasis_3 = mkColorTriple "base0F";
            };
            frame_selected = {
              base = mkColorTriple "base0E";
              background = mkColorTriple "base00";
              emphasis_0 = mkColorTriple "base09";
              emphasis_1 = mkColorTriple "base0C";
              emphasis_2 = mkColorTriple "base0F";
              emphasis_3 = mkColorTriple "base00";
            };
            frame_highlight = {
              base = mkColorTriple "base08";
              background = mkColorTriple "base00";
              emphasis_0 = mkColorTriple "base0F";
              emphasis_1 = mkColorTriple "base09";
              emphasis_2 = mkColorTriple "base09";
              emphasis_3 = mkColorTriple "base09";
            };
            exit_code_success = {
              base = mkColorTriple "base0B";
              background = mkColorTriple "base00";
              emphasis_0 = mkColorTriple "base0C";
              emphasis_1 = mkColorTriple "base01";
              emphasis_2 = mkColorTriple "base0F";
              emphasis_3 = mkColorTriple "base0D";
            };
            exit_code_error = {
              base = mkColorTriple "base08";
              background = mkColorTriple "base00";
              emphasis_0 = mkColorTriple "base0A";
              emphasis_1 = mkColorTriple "base00";
              emphasis_2 = mkColorTriple "base00";
              emphasis_3 = mkColorTriple "base00";
            };
            multiplayer_user_colors = {
              player_1 = mkColorTriple "base0F";
              player_2 = mkColorTriple "base0D";
              player_3 = mkColorTriple "base00";
              player_4 = mkColorTriple "base0A";
              player_5 = mkColorTriple "base0C";
              player_6 = mkColorTriple "base00";
              player_7 = mkColorTriple "base08";
              player_8 = mkColorTriple "base00";
              player_9 = mkColorTriple "base00";
              player_10 = mkColorTriple "base00";
            };
          };
        };
      };
    };
}
