{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "nvim flake-parts/flake.nix";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.neovim.enable = true;
  };
}
