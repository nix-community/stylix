{ lib, ... }:
{
  stylix.testbed.ui.command.text = "foot";

  home-manager.sharedModules = lib.singleton {
    programs.foot.enable = true;
  };
}
