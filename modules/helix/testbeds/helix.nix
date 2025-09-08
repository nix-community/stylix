{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "hx flake-parts/flake.nix";
  };

  home-manager.sharedModules = lib.singleton {
    programs.helix.enable = true;
  };
}
