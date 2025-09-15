{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "nu";
  };

  home-manager.sharedModules = lib.singleton {
    programs.nushell.enable = true;
  };
}
