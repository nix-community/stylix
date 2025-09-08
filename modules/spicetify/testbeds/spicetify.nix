{ lib, pkgs, ... }:
{
  stylix.testbed = {
    enable = lib.meta.availableOn pkgs.stdenv.hostPlatform pkgs.spotify;
    ui.command.text = "spotify";
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [ "spotify" ];

  programs.spicetify.enable = true;
}
