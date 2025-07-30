{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "btop";
  };

  home-manager.sharedModules = lib.singleton {
    programs.btop.enable = true;
  };
}
