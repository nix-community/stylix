{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "ashell";
  };

  home-manager.sharedModules = lib.singleton {
    programs.ashell.enable = true;
  };
}
