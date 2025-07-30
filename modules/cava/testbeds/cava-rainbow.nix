{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    packages = [ pkgs.alsa-utils ];
    text = "aplay /dev/urandom & cava";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.cava.enable = true;
    stylix.targets.cava.rainbow.enable = true;
  };
}
