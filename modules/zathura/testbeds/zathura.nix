{ lib, ... }:
{
  stylix.testbed.ui.command.text = "zathura";

  home-manager.sharedModules = lib.singleton {
    programs.zathura.enable = true;
  };
}
