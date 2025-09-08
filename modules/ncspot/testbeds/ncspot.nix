{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "ncspot";
  };

  home-manager.sharedModules = lib.singleton {
    programs.ncspot.enable = true;
  };
}
