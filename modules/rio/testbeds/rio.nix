{ lib, ... }:
{
  stylix.testbed.ui.command.text = "rio";

  home-manager.sharedModules = lib.singleton {
    programs.rio.enable = true;
  };
}
