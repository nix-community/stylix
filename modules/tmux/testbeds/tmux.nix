{ pkgs, lib, ... }:
{
  stylix.testbed.ui.command = {
    text = pkgs.tmux;
    useTerminal = true;
  };
  home-manager.sharedModules = lib.singleton {
    programs.tmux.enable = true;
  };
}
