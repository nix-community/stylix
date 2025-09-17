{
  mkTarget,
  pkgs,
  lib,
  ...
}:
let
  iconNames = [
    "hibernate"
    "lock"
    "logout"
    "reboot"
    "shutdown"
    "suspend"
  ];
  mkIcons =
    color:
    pkgs.runCommand "stylix-wlogout-icons" { buildInputs = [ pkgs.imagemagick ]; }
      ''
        ICONS=(${lib.escapeShellArgs iconNames})
        mkdir -p $out
        for icon in "''${ICONS[@]}"; do
          sed ${pkgs.wlogout.src}/assets/$icon.svg \
            -e "s/<svg/<svg fill=\"${color}\"/" \
            | convert -background none - -resize 512x512 $out/$icon.png
        done
      '';
in
mkTarget {
  name = "wlogout";
  humanName = "wlogout";

  extraOptions =
    { colors }:
    {
      background = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Used to set bg even if `opacity` or `colors` is null";
        internal = true;
        default = null;
      };
      font = lib.mkOption {
        type = lib.types.enum [
          "serif"
          "sansSerif"
          "monospace"
          "emoji"
        ];
        default = "sansSerif";
        example = "monospace";
        description = "The stylix font for wlogout to use";
      };
      addCss = lib.mkOption {
        type = lib.types.bool;
        default = true;
        example = false;
        description = "Adds fully functional css (otherwise just adds colors and fonts)";
      };
      iconColor = lib.mkOption {
        type = with lib.types; nullOr str;
        default = colors.withHashtag.base0E or null;
        example = lib.literalExpression "colors.withHashtag.base0E";
        defaultText = lib.literalExpression "colors.withHashtag.base0E or null";
        description = "The color of the icons in the stylix.targets.wlogout.coloredIcons package";
      };
      coloredIcons = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
        description =
          "A package containing the "
          + lib.concatStringsSep ", " (map (i: i + ".png") iconNames)
          + " icons colored with stylix.targets.wlogout.iconColor.";
      };
    };

  configElements = [
    (
      { cfg }:
      {
        stylix.targets.wlogout.coloredIcons = mkIcons cfg.iconColor;
      }
    )
    (
      { colors }:
      {
        programs.wlogout.style =
          with colors.withHashtag;
          lib.mkBefore ''
            @define-color base00 ${base00}; @define-color base01 ${base01};
            @define-color base02 ${base02}; @define-color base03 ${base03};
            @define-color base04 ${base04}; @define-color base05 ${base05};
            @define-color base06 ${base06}; @define-color base07 ${base07};

            @define-color base08 ${base08}; @define-color base09 ${base09};
            @define-color base0A ${base0A}; @define-color base0B ${base0B};
            @define-color base0C ${base0C}; @define-color base0D ${base0D};
            @define-color base0E ${base0E}; @define-color base0F ${base0F};
          '';
      }
    )
    (
      { fonts, cfg }:
      {
        programs.wlogout.style = ''
          * {
            font-family: "${fonts.${cfg.font}.name}";
            font-size: ${toString fonts.sizes.desktop}pt;
          }
        '';
      }
    )
    (
      { cfg }:
      {
        programs.wlogout.style = lib.mkIf (cfg.addCss && cfg.background != null) ''
          window {
            background-color: ${cfg.background};
          }
        '';
      }
    )
    (
      { opacity, colors }:
      {
        stylix.targets.wlogout.background = "alpha(@base00, ${toString opacity.popups})";
      }
    )
    (
      { cfg }:
      {
        programs.wlogout.style = lib.mkIf cfg.addCss (
          let
            mkIconStyle = iconName: ''
              #${iconName} {
                background-image: url("${cfg.coloredIcons}/${iconName}.png");
              }
            '';
          in
          ''
            * {
              background-image: none;
              box-shadow: none;
            }

            button {
              border-radius: 0;
              border-color: @base03;
              text-decoration-color: @base05;
              color: @base05;
              background-color: @base01;
              border-style: solid;
              border-width: 1px;
              background-repeat: no-repeat;
              background-position: center;
              background-size: 25%;
            }

            button:focus, button:active, button:hover {
              background-color: @base02;
              outline-style: none;
            }
          ''
          + lib.concatStringsSep "\n" (map mkIconStyle iconNames)
        );
      }
    )
  ];
}
