{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "noctalia";
  };

  home-manager.sharedModules = lib.singleton { programs.noctalia.enable = true; };
}
