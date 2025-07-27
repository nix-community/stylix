{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "hx flake-parts/flake.nix";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.helix.enable = true;
  };
}
