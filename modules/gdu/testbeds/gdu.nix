{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "gdu";
  };

  home-manager.sharedModules = lib.singleton {
    home.packages = [ pkgs.gdu ];
  };
}
