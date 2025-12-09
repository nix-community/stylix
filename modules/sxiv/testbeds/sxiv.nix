{ lib, pkgs, ... }:
let
  package = pkgs.nsxiv;
in
{
  stylix.testbed.ui.command.text = ''
    # Xresources isn't loaded by default, so we force it
    ${lib.getExe pkgs.xorg.xrdb} ~/.Xresources

    ${lib.getExe package} \
      "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
  '';

  home-manager.sharedModules = lib.singleton { home.packages = [ package ]; };
}
