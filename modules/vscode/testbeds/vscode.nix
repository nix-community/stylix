{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command.text = "code flake-parts/flake.nix";

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [ "vscode" ];

  home-manager.sharedModules = lib.singleton {
    programs.vscode = {
      package = pkgs.vscode;
      enable = true;
    };
  };
}
