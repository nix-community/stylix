{
  lib,
  config,
  ...
}:

let
  autoload = import ../autoload.nix { inherit lib; } "hm";
in
{
  imports = [
    # keep-sorted start
    ../cursor.nix
    ../fonts.nix
    ../icon.nix
    ../opacity.nix
    ../overlays.nix
    ../palette.nix
    ../pixel.nix
    ../release.nix
    ../target.nix
    ./cursor.nix
    ./icon.nix
    ./palette.nix
    # keep-sorted end
  ] ++ autoload;
  config.warnings =
    lib.mkIf
      (
        config.stylix.enable
        && config.stylix.enableReleaseChecks
        && (config.stylix.release != config.home.version.release)
      )
      [
        ''
          You are using different Stylix and Home Manager versions. This is
          likely to cause errors and unexpected behavior. It is highly
          recommended that you use a version of Stylix that matches your chosen
          version of Home Manager.

          If you are willing to accept the risks that come with using
          mismatched versions, you may disable this warning by adding

              stylix.enableReleaseChecks = false;

          to your configuration.
        ''
      ];
}
