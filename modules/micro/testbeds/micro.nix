{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = "${lib.getExe pkgs.micro} flake-parts/flake.nix";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.micro.enable = true;
  };
}
