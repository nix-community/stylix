{
  lib,
  config,
  ...
}:

let
  autoload = import ../autoload.nix { inherit lib; } "nixos";
in
{
  imports = [
    # keep-sorted start
    ../cursor.nix
    ../fonts.nix
    ../home-manager-integration.nix
    ../opacity.nix
    ../overlays.nix
    ../palette.nix
    ../pixel.nix
    ../release.nix
    ../target.nix
    ./cursor.nix
    ./palette.nix
    # keep-sorted end
  ] ++ autoload;
  config.warnings =
    lib.mkIf
      (
        config.stylix.enable
        && config.stylix.enableReleaseChecks
        && (config.stylix.release != config.system.nixos.release)
      )
      [
        ''
          You are using different Stylix and NixOS versions. This is
          likely to cause errors and unexpected behavior. It is highly
          recommended that you use a version of Stylix that matches your chosen
          version of NixOS.

          If you are willing to accept the risks that come with using
          mismatched versions, you may disable this warning by adding

              stylix.enableReleaseChecks = false;

          to your configuration.
        ''
      ];
}
