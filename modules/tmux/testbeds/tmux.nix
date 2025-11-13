{ pkgs, lib, ... }:
{
  stylix.testbed.ui.command = {
    text = lib.getExe pkgs.tmux;
    useTerminal = true;
  };
  home-manager.sharedModules = lib.singleton {
    programs.tmux.enable = true;
  };
}
