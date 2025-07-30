{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "opencode";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.opencode.enable = true;
  };
}
