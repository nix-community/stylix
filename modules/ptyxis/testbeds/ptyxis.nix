{ lib, pkgs, ... }:
let
  package = pkgs.ptyxis;
in
{
  stylix.testbed.ui.application = {
    name = "ptyxis";
    inherit package;
  };

  home-manager.sharedModules = lib.singleton {
    programs.foot = {
      enable = true;
      inherit package;
    };
  };
}
