{ pkgs, lib, ... }:
{
  stylix.testbed.ui.command = {
    text = lib.getExe pkgs.ncspot;
    useTerminal = true;
  };
  home-manager.sharedModules = lib.singleton { programs.ncspot.enable = true; };
}
