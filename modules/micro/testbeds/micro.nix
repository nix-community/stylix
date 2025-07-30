{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "micro flake-parts/flake.nix";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.micro.enable = true;
  };
}
