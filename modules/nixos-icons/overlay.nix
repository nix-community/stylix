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
            prePatch = with config.lib.stylix.colors; ''
              substituteInPlace logo/nix-snowflake-white.svg --replace-fail '#ffffff' '#${base05}'

              # The normal snowflake uses 2 gradients, replace each bluish color with blue and each light-blueish color with cyan
              for color in '#699ad7' '#7eb1dd' '#7ebae4'; do
                substituteInPlace logo/nix-snowflake-colours.svg --replace-fail $color '#${base0C}'
              done
              for color in '#415e9a' '#4a6baf' '#5277c3'; do
                substituteInPlace logo/nix-snowflake-colours.svg --replace-fail $color '#${base0D}'
              done

              # Insert attribution comment after the XML prolog
              attribution='2i<!-- The original NixOS logo from ${oldAttrs.src.url} is licensed under https://creativecommons.org/licenses/by/4.0 and has been modified to match the ${scheme} color scheme. -->'
              sed --in-place "$attribution" logo/nix-snowflake-colours.svg
              sed --in-place "$attribution" logo/nix-snowflake-white.svg
            '';
          };
        });
      };
}
