{ lib, pkgs, ... }:
let
  package = pkgs.prismlauncher;
in
{
  stylix.testbed.ui.command.text = lib.getExe package;

  home-manager.sharedModules = lib.singleton {
    programs.prismlauncher = {
      enable = true;
      inherit package;
    };
  };
}
