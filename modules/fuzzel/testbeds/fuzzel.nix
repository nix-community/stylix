{ lib, ... }:
{
  stylix.testbed.ui = {
    command.text = "fuzzel";
    graphicalEnvironment = "hyprland";
  };

  home-manager.sharedModules = lib.singleton {
    programs.fuzzel.enable = true;
  };
}
