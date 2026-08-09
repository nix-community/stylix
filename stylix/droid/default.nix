{
  lib,
  pkgs,
  config,
  ...
}:
let
  autoload = import ../autoload.nix { inherit lib pkgs; } "droid";
in
{
  imports = [
    ./fonts.nix
    ./palette.nix
    ../colors.nix
    ../fonts.nix
    ../home-manager-integration.nix
    ../opacity.nix
    ../palette.nix
    ../pixel.nix
    ../target.nix
    ../overlays.nix
    ../ordering.nix
  ]
  ++ autoload;

  # See https://github.com/nix-community/nix-on-droid/issues/436
  options.lib = lib.mkOption { type = with lib.types; attrsOf attrs; };

  config.warnings = lib.mkIf config.stylix.enable [
    ''
      Nix-on-Droid upstream appears unmaintained (few commits over the
      past year, an unsupported Nixpkgs version, and reports of breakage
      on current NixOS), so Stylix's Nix-on-Droid target may be dropped
      without expressions of maintenance interest.

      If you rely on Stylix on Nix-on-Droid, please comment on
      https://github.com/nix-community/stylix/discussions/2402 to help
      gauge whether this target should be kept.
    ''
  ];
}
