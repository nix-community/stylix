{ lib, pkgs, ... }: {
  stylix.testbed.ui.command = {
    text = lib.getExe pkgs.herdr;
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton { programs.herdr.enable = true; };
}
