{ lib, ... }:
{
  stylix.testbed.ui.command.text = "mpv";

  home-manager.sharedModules = lib.singleton {
    programs.mpv.enable = true;
  };
}
