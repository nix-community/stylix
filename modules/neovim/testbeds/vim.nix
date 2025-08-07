{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = "${lib.getExe pkgs.vim} flake-parts/flake.nix";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.vim.enable = true;
  };
}
