{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "micro flake-parts/flake.nix";
  };

  home-manager.sharedModules = lib.singleton {
    programs.micro.enable = true;
  };
}
