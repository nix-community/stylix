{
  mkTarget,
  pkgs,
  lib,
  ...
}:
let
  iconNames = [
    "lock"
    "logout"
    "suspend"
    "hibernate"
    "shutdown"
    "reboot"
  ];
  mkIcons =
    color:
    pkgs.runCommand "stylix-wlogout-icons" { } ''
      ICONS=(${lib.concatStringsSep " " iconNames})
      mkdir -p $out/share/wlogout/icons
      for icon in "''${ICONS[@]}"; do
        sed ${pkgs.wlogout.src}/assets/$icon.svg \
          -e "s/<svg/<svg fill=\"#${color}\"/" \
          >$out/$icon.svg
      done
    '';
in
mkTarget {
  name = "wlogout";
  humanName = "wlogout";

  extraOptions = {
    font = lib.mkOption {
      type = lib.types.enum [
        "serif"
        "sansSerif"
        "monospace"
        "emoji"
      ];
      default = "sansSerif";
      example = "monospace";
      description = "The font for wlogout to use";
    };
    addCss = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "adds fully functional css (otherwise just adds colors and fonts)";
    };
  };

  configElements = [
    (
      {
        colors,
        opacity,
        fonts,
        cfg,
      }:
      {
        #FIXME upstream: the home-manager wlogout style option is using str instead of lines so it must be set in a single module
        programs.wlogout.style =
          let
            icons = mkIcons colors.base0E;
            mkIconStyle = iconName: ''
              #${iconName} {
                background-image: image(url("${icons}/${iconName}.svg"));
              }
            '';
          in
          (with colors.withHashtag; ''
            @define-color base00 ${base00}; @define-color base01 ${base01};
            @define-color base02 ${base02}; @define-color base03 ${base03};
            @define-color base04 ${base04}; @define-color base05 ${base05};
            @define-color base06 ${base06}; @define-color base07 ${base07};

            @define-color base08 ${base08}; @define-color base09 ${base09};
            @define-color base0A ${base0A}; @define-color base0B ${base0B};
            @define-color base0C ${base0C}; @define-color base0D ${base0D};
            @define-color base0E ${base0E}; @define-color base0F ${base0F};

            * {
              font-family: "${fonts.${cfg.font}.name}";
              font-size: ${builtins.toString fonts.sizes.desktop}pt;
            }
          '')
          + lib.optionalString cfg.addCss ''
            * {
                background-image: none;
                box-shadow: none;
            }

            window {
                background-color: alpha(@base00, ${builtins.toString opacity.popups});
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

            ${lib.concatStringsSep "\n" (map mkIconStyle iconNames)}
          '';
      }
    )
  ];
}
