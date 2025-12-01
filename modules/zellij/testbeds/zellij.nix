{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "zellij";
  };

  home-manager.sharedModules = lib.singleton {
    programs.zellij.enable = true;
  };
}
