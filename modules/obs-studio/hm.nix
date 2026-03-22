{
  mkTarget,
  lib,
  ...
}:
mkTarget {
  config = [
    (
      {colors}: {
        xdg.configFile."obs-studio/themes/Stylix.obt".text = builtins.readFile ./Stylix.obt;
        xdg.configFile."obs-studio/themes/Stylix_Colors.obt".text = ''
          @OBSThemeVars {
              --ctp_rosewater: ${colors.base06};
              --ctp_flamingo: ${colors.base0F};
              --ctp_pink: ${colors.base0F};
              --ctp_mauve: ${colors.base0E};
              --ctp_red: ${colors.base08};
              --ctp_maroon: ${colors.base0F};
              --ctp_peach: ${colors.base09};
              --ctp_yellow: ${colors.base0A};
              --ctp_green: ${colors.base0B};
              --ctp_teal: ${colors.base0C};
              --ctp_sky: ${colors.base0D};
              --ctp_sapphire: ${colors.base0D};
              --ctp_blue: ${colors.base0D};
              --ctp_lavender: ${colors.base07};
              --ctp_text: ${colors.base05};
              --ctp_subtext1: ${colors.base05};
              --ctp_subtext0: ${colors.base05};
              --ctp_overlay2: ${colors.base04};
              --ctp_overlay1: ${colors.base03};
              --ctp_overlay0: ${colors.base03};
              --ctp_surface2: ${colors.base04};
              --ctp_surface1: ${colors.base03};
              --ctp_surface0: ${colors.base02};
              --ctp_base: ${colors.base00};
              --ctp_mantle: ${colors.base01};
              --ctp_crust: ${colors.base01};
              --ctp_selection_background: ${colors.base02};
          }

          ${builtins.readFile ./Colors.ovt}
        '';
      }
    )
  ];
}
