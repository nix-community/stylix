{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "fuzzel";
  };

  home-manager.sharedModules = lib.singleton {
    programs.fuzzel.enable = true;
  };
}
