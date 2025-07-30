{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "bat flake-parts/flake.nix";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.bat.enable = true;
  };
}
