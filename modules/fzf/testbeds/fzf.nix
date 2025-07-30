{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "fzf";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.fzf.enable = true;
  };
}
