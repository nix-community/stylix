{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "vim flake-parts/flake.nix";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.vim.enable = true;
  };
}
