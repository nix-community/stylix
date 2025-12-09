{ lib, pkgs, ... }:
let
  package = pkgs.obsidian;
in
{
  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [ "obsidian" ];

  stylix.testbed.ui.application = {
    name = "obsidian";
    inherit package;
  };

  home-manager.sharedModules =
    let
      vault = "stylix";
    in
    lib.singleton {
      programs.obsidian = {
        enable = true;
        vaults.${vault}.enable = true;
        inherit package;
      };
      stylix.targets.obsidian.vaultNames = [ vault ];
    };
}
