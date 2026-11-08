{ lib, pkgs, ... }: {
  stylix.testbed.ui.command = {
    text = "${lib.getExe pkgs.gram} flake-parts/flake.nix";
  };

  home-manager.sharedModules = lib.singleton { programs.gram.enable = true; };
}
