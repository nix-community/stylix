{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "fzf";
  };

  home-manager.sharedModules = lib.singleton {
    programs.fzf.enable = true;
  };
}
