{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "tmux";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.tmux.enable = true;
  };
}
