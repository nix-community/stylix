{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = "broot";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton { programs.broot.enable = true; };
}
