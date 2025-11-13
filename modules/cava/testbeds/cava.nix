{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = ''
      ${lib.getExe' pkgs.alsa-utils "aplay"} /dev/urandom &
      ${lib.getExe pkgs.cava}
    '';
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.cava.enable = true;
  };
}
