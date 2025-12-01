{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    packages = [ pkgs.alsa-utils ];
    terminal = true;
    text = "aplay /dev/urandom & cava";
  };

  home-manager.sharedModules = lib.singleton {
    programs.cava.enable = true;
  };
}
