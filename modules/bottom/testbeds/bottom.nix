{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = lib.getExe pkgs.bottom;
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton { programs.bottom.enable = true; };
}
