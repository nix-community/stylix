{
  lib,
  pkgs,
  config,
  ...
}:
{
  stylix.testbed = {
    # Spotify is not available on arm64.
    enable = lib.meta.availableOn pkgs.stdenv.hostPlatform pkgs.spotify;

    ui.command = {
      text = lib.getExe config.programs.spicetify.spicedSpotify;
    };
  };

  programs.spicetify.enable = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [ "spotify" ];
}
