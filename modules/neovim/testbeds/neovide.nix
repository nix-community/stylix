{ lib, ... }:
{
  stylix.testbed.ui.command.text = "neovide flake-parts/flake.nix";

  home-manager.sharedModules = lib.singleton {
    programs = {
      neovide.enable = true;
      neovim.enable = true;
    };
  };
}
