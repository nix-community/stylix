{ lib, pkgs, ... }:
let
  package = pkgs.sioyek;
in
{
  stylix.testbed.ui.application = {
    name = "sioyek";
    inherit package;
  };

  home-manager.sharedModules = lib.singleton {
    programs.sioyek = {
      enable = true;
      inherit package;
    };
  };
}
