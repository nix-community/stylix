{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (builtins) stringLength substring;

  inherit (lib)
    concatStrings
    max
    min
    pipe
    toHexString
    fromHexString
    mkOption
    types
    ;

  cfg = config.stylix.targets.nixos-icons;

  strMatchingHexColor = types.strMatching "^[a-zA-Z0-9]{6}$";

  hexColorAddRgb =
    hexColor: add:
    pipe hexColor [
      # convert to hex color to rgb attrset, and add specified value
      (
        _:
        map
          (
            elem:
            fromHexString (
              if elem == "r" then
                substring 0 2 hexColor
              else if elem == "g" then
                substring 2 2 hexColor
              else
                substring 4 2 hexColor
            )
            + add.${elem}
          )
          [
            "r"
            "g"
            "b"
          ]
      )
      # clamp between 0 and 255
      (map (min 255))
      (map (max 0))
      # convert each to hex string
      (map toHexString)
      # add leading 0 if necessary
      (map (hex: if (stringLength hex < 2) then "0" + hex else hex))
      # to one string
      concatStrings
    ];
in
{
  options.stylix.targets.nixos-icons = {
    enable = config.lib.stylix.mkEnableTarget "the NixOS logo" true;
    hexColorAddRgb = mkOption {
      readOnly = true;
      default = hexColorAddRgb;
      description = "Function that adds RGB values to a hex color. For example `hexColorAddRgb \"000000\" {r = 128; g = 128; b = 128;}` evaluates to `\"808080\"`";
    };
    colors = {
      nix-snowflake-white.white = mkOption {
        default = config.lib.stylix.colors.base05;
        defaultText = "config.lib.stylix.colors.base05";
        description = "Replaces the white color in the 'nix-snowflake-white' icon.";
        type = strMatchingHexColor;
      };
      nix-snowflake = {
        light-blue-darker = mkOption {
          default =
            with config.stylix.targets.nixos-icons;
            hexColorAddRgb colors.nix-snowflake.light-blue {
              r = -21;
              g = -23;
              b = -6;
            };
          defaultText = ''
            with config.stylix.targets.nixos-icons;
            hexColorAddRgb colors.nix-snowflake.light-blue {
              r = -21;
              g = -23;
              b = -6;
            };
          '';
          description = "Replaces the darker part of light blue color gradient (#699ad7) in the 'nix-snowflake-colours' icon.";
          type = strMatchingHexColor;
        };
        light-blue = mkOption {
          default = config.lib.stylix.colors.base0C;
          defaultText = "config.lib.stylix.colors.base0C";
          description = "Replaces the neutral part of light blue color gradient (#7eb1dd) in the 'nix-snowflake-colours' icon.";
          type = strMatchingHexColor;
        };
        light-blue-lighter = mkOption {
          default =
            with config.stylix.targets.nixos-icons;
            hexColorAddRgb colors.nix-snowflake.light-blue {
              r = 0;
              g = 9;
              b = 7;
            };
          defaultText = ''
            with config.stylix.targets.nixos-icons;
            hexColorAddRgb colors.nix-snowflake.light-blue {
              r = 0;
              g = 9;
              b = 7;
            };
          '';
          description = "Replaces the lighter part of light blue color gradient (#7ebae4) the 'nix-snowflake-colours' icon.";
          type = strMatchingHexColor;
        };
        blue-darker = mkOption {
          default =
            with config.stylix.targets.nixos-icons;
            hexColorAddRgb colors.nix-snowflake.blue {
              r = -9;
              g = -13;
              b = -21;
            };
          defaultText = ''
            with config.stylix.targets.nixos-icons;
            hexColorAddRgb colors.nix-snowflake.blue {
              r = -9;
              g = -13;
              b = -21;
            };
          '';
          description = "Replaces the darker part of blue color gradient (#415e9a) in the 'nix-snowflake-colours' icon.";
          type = strMatchingHexColor;
        };
        blue = mkOption {
          default = config.lib.stylix.colors.base0D;
          defaultText = "config.lib.stylix.colors.base0D";
          description = "Replaces the neutral part of blue color gradient (#4a6baf) in the 'nix-snowflake-colours' icon.";
          type = strMatchingHexColor;
        };
        blue-lighter = mkOption {
          default =
            with config.stylix.targets.nixos-icons;
            hexColorAddRgb colors.nix-snowflake.blue {
              r = 8;
              g = 12;
              b = 20;
            };
          defaultText = ''
            with config.stylix.targets.nixos-icons;
            hexColorAddRgb colors.nix-snowflake.blue {
              r = 8;
              g = 12;
              b = 20;
            };
          '';
          description = "Replaces the lighter part of blue color gradient (#5277c3) the 'nix-snowflake-colours' icon.";
          type = strMatchingHexColor;
        };
      };
    };
  };

  overlay =
    _: super:
    lib.optionalAttrs (config.stylix.enable && cfg.enable) {
      nixos-icons = super.nixos-icons.overrideAttrs (oldAttrs: {
        src = pkgs.applyPatches {
          inherit (oldAttrs) src;
          prePatch = ''
            substituteInPlace \
              logo/nix-snowflake-white.svg \
              --replace-fail \
              '#ffffff' \
              '#${cfg.colors.nix-snowflake-white.white}'

            # The normal snowflake uses 2 gradients, replace each bluish
            # color with blue and each light-blueish color with cyan
            substituteInPlace \
              logo/nix-snowflake-colours.svg \
              --replace-fail \
              '#699ad7' \
              '#${cfg.colors.nix-snowflake.light-blue-darker}'

            substituteInPlace \
              logo/nix-snowflake-colours.svg \
              --replace-fail \
              '#7eb1dd' \
              '#${cfg.colors.nix-snowflake.light-blue}'

            substituteInPlace \
              logo/nix-snowflake-colours.svg \
              --replace-fail \
              '#7ebae4' \
              '#${cfg.colors.nix-snowflake.light-blue-lighter}'

            substituteInPlace \
              logo/nix-snowflake-colours.svg \
              --replace-fail \
              '#415e9a' \
              '#${cfg.colors.nix-snowflake.blue-darker}'

            substituteInPlace \
              logo/nix-snowflake-colours.svg \
              --replace-fail \
              '#4a6baf' \
              '#${cfg.colors.nix-snowflake.blue}'

            substituteInPlace \
              logo/nix-snowflake-colours.svg \
              --replace-fail \
              '#5277c3' \
              '#${cfg.colors.nix-snowflake.blue-lighter}'

            # Insert attribution comment after the XML prolog
            attribution='2i<!-- The original NixOS logo from ${oldAttrs.src.url} is licensed under https://creativecommons.org/licenses/by/4.0 and has been modified to match the ${config.lib.stylix.colors.scheme} color scheme. -->'
            sed --in-place "$attribution" logo/nix-snowflake-colours.svg
            sed --in-place "$attribution" logo/nix-snowflake-white.svg
          '';
        };
      });
    };
}
