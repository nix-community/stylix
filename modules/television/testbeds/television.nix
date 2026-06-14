{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = lib.getExe pkgs.television;
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.television.enable = true;
  };
}
