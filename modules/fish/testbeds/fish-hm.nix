{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "fish";
  };

  home-manager.sharedModules = lib.singleton {
    programs.fish.enable = true;
  };
}
