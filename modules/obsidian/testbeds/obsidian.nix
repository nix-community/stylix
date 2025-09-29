{ lib, pkgs, ... }:
let
  package = pkgs.obsidian;
in
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "obsidian"
    ];

  stylix.testbed.ui.application = {
    name = "obsidian";
    inherit package;
  };

  home-manager.sharedModules = lib.singleton {
    programs.obsidian = {
      enable = true;
      vaults.stylix = {
        enable = true;
        target = "stylix-vault";
      };
      inherit package;
    };
    stylix.targets.obsidian.vaultNames = [ "stylix" ];
  };
}
