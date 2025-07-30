{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "tmux";
  };

  home-manager.sharedModules = lib.singleton {
    programs.tmux.enable = true;
  };
}
