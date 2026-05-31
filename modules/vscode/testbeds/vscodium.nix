{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command.text = "codium flake-parts/flake.nix";

  home-manager.sharedModules = lib.singleton {
    programs.vscodium = {
      enable = true;
    };
  };
}
