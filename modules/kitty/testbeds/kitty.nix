{ lib, ... }:
{
  stylix.testbed.ui.command.text = "kitty";

  home-manager.sharedModules = lib.singleton {
    programs.kitty.enable = true;
  };
}
