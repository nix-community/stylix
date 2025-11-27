{ lib, ... }:
{
  stylix.testbed.ui.text = "obsidian";

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [ "obsidian" ];

  home-manager.sharedModules =
    let
      vault = "stylix";
    in
    lib.singleton {
      stylix.targets.obsidian.vaultNames = [ vault ];

      programs.obsidian = {
        enable = true;
        vaults.${vault}.enable = true;
      };
    };
}
