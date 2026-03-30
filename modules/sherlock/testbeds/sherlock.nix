{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "sherlock";
  };

  home-manager.sharedModules = lib.singleton { programs.sherlock.enable = true; };
}
