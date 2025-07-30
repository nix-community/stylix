{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command.text = "mpv";

  home-manager.sharedModules = lib.singleton {
    programs.mpv = {
      enable = true;
      scripts = [ pkgs.mpvScripts.uosc ];
    };
  };
}
