{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.stylix.targets.nixos-icons.enable =
    config.lib.stylix.mkEnableTarget "the NixOS logo" true;

  overlay =
    _: super:
    lib.optionalAttrs
      (config.stylix.enable && config.stylix.targets.nixos-icons.enable)
      {
        nixos-icons = super.nixos-icons.overrideAttrs (oldAttrs: {
          src = pkgs.applyPatches {
            inherit (oldAttrs) src;
            prePatch =
              let
                inherit (config.lib.stylix) colors;

                inherit (lib)
                  concatStrings
                  max
                  min
                  pipe
                  toHexString
                  toInt
                  ;

                baseColorAdd =
                  colorName: add:
                  pipe colorName [
                    # convert to base color name to rgb attrset, and add specified value
                    (
                      colorName:
                      map (elem: toInt colors."${colorName}-rgb-${elem}" + add.${elem}) [
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
                    # to one string
                    concatStrings
                  ];
              in
              ''
                substituteInPlace \
                  logo/nix-snowflake-white.svg \
                  --replace-fail \
                  '#ffffff' \
                  '#${colors.base05}'

                # The normal snowflake uses 2 gradients, replace each bluish
                # color with blue and each light-blueish color with cyan
                substituteInPlace \
                  logo/nix-snowflake-colours.svg \
                  --replace-fail \
                  '#699ad7' \
                  '#${
                    baseColorAdd "base0C" {
                      r = -21;
                      g = -23;
                      b = -6;
                    }
                  }'

                substituteInPlace \
                  logo/nix-snowflake-colours.svg \
                  --replace-fail \
                  '#7eb1dd' \
                  '#${colors.base0C}'

                substituteInPlace \
                  logo/nix-snowflake-colours.svg \
                  --replace-fail \
                  '#7ebae4' \
                  '#${
                    baseColorAdd "base0C" {
                      r = 0;
                      g = 9;
                      b = 7;
                    }
                  }'

                substituteInPlace \
                  logo/nix-snowflake-colours.svg \
                  --replace-fail \
                  '#415e9a' \
                  '#${
                    baseColorAdd "base0D" {
                      r = -9;
                      g = -13;
                      b = -21;
                    }
                  }'

                substituteInPlace \
                  logo/nix-snowflake-colours.svg \
                  --replace-fail \
                  '#4a6baf' \
                  '#${colors.base0D}'

                substituteInPlace \
                  logo/nix-snowflake-colours.svg \
                  --replace-fail \
                  '#5277c3' \
                  '#${
                    baseColorAdd "base0D" {
                      r = 8;
                      g = 12;
                      b = 20;
                    }
                  }'

                # Insert attribution comment after the XML prolog
                attribution='2i<!-- The original NixOS logo from ${oldAttrs.src.url} is licensed under https://creativecommons.org/licenses/by/4.0 and has been modified to match the ${colors.scheme} color scheme. -->'
                sed --in-place "$attribution" logo/nix-snowflake-colours.svg
                sed --in-place "$attribution" logo/nix-snowflake-white.svg
              '';
          };
        });
      };
}
