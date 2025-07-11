{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command.text = "emacs flake-parts/flake.nix";

  home-manager.sharedModules = lib.singleton {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
    };
  };
}
