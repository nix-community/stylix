{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = pkgs.btop;
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.btop.enable = true;
  };
}
