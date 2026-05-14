{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = lib.getExe pkgs.aerc;
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton { programs.aerc.enable = true; };
}
