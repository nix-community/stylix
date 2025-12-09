{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = "gdu";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton { home.packages = [ pkgs.gdu ]; };
}
