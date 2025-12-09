{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = lib.getExe pkgs.opencode;
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton { programs.opencode.enable = true; };
}
