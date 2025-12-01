{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command.text = pkgs.cavalier.meta.mainProgram;

  home-manager.sharedModules = lib.singleton {
    programs.cavalier.enable = true;
  };
}
