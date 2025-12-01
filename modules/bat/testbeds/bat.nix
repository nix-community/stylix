{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "bat flake-parts/flake.nix";
  };

  home-manager.sharedModules = lib.singleton {
    programs.bat.enable = true;
  };
}
