{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "nvim flake-parts/flake.nix";
  };

  home-manager.sharedModules = lib.singleton {
    programs.neovim.enable = true;
  };
}
