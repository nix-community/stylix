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
      vaults = {
        test = {
          enable = true;
          target = "obsidian-vault";
        };
      };
      inherit package;
    };
  };
}
