{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command.text = lib.getExe pkgs.wayle;
  home-manager.sharedModules = lib.singleton { services.wayle.enable = true; };
}
