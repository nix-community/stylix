{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command.text = "codium flake-parts/flake.nix";

  home-manager.sharedModules = lib.singleton {
    programs.vscode = {
      enable = true;

      # We are using VSCodium because VSCode is an unfree package
      package = pkgs.vscodium;
    };
  };
}
