{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = lib.getExe pkgs.eza;
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton { programs.eza.enable = true; };
}
