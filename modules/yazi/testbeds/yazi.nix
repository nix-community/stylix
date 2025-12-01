{ lib, ... }:
{
  stylix.testbed.ui.command.text = "yazi";

  home-manager.sharedModules = lib.singleton {
    programs.yazi.enable = true;
  };
}
