{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "opencode";
  };

  home-manager.sharedModules = lib.singleton {
    programs.opencode.enable = true;
  };
}
