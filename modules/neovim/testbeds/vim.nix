{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "vim flake-parts/flake.nix";
  };

  home-manager.sharedModules = lib.singleton {
    programs.vim.enable = true;
  };
}
