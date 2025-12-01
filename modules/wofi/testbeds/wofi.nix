{ lib, ... }:
{
  stylix.testbed.ui.command.text = "wofi --allow-images --show drun";

  home-manager.sharedModules = lib.singleton {
    programs.wofi.enable = true;
  };
}
