{ lib, pkgs, ... }:

let
  package = pkgs.rio;
in
{
  stylix.testbed.ui.application = {
    name = "rio";
    inherit package;
  };

  home-manager.sharedModules = lib.singleton {
    programs.rio = {
      enable = true;
      inherit package;
    };
  };
}
