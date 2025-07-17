{ pkgs, lib, ... }:
{
  stylix.testbed.ui.command = {
    text = pkgs.ncspot;
    useTerminal = true;
  };
  home-manager.sharedModules = lib.singleton {
    programs.ncspot.enable = true;
  };
}
