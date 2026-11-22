{
  lib,
  pkgs,
  config,
  ...
}:
let
  autoload = import ../autoload.nix { inherit lib pkgs; } "hm";
in
{
  imports = [
    (lib.mkRemovedOptionModule [ "stylix" "targets" "wayprompt" "enable" ]
      "The wayprompt target was removed because nixpkgs dropped the wayprompt package, so 'programs.wayprompt' no longer has any effect. Remove this option from your configuration."
    )
    ./cursor.nix
    ./icons.nix
    ./palette.nix
    ../colors.nix
    ../cursor.nix
    ../fonts.nix
    ../icons.nix
    ../opacity.nix
    ../palette.nix
    ../pixel.nix
    ../target.nix
    ../release.nix
    ../overlays.nix
    ../ordering.nix
  ]
  ++ autoload;
  config.warnings =
    lib.mkIf
      (
        config.stylix.enable
        && config.stylix.enableReleaseChecks
        && config.stylix.release != config.home.version.release
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
