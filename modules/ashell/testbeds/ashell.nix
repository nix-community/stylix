{ lib, ... }:
{
  stylix.testbed.ui = {
    command.text = "ashell";
    graphicalEnvironment = "hyprland";
  };

  home-manager.sharedModules = lib.singleton {
    programs.ashell.enable = true;
  };
}
