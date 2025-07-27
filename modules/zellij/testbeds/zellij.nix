{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "zellij";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.zellij.enable = true;
  };
}
