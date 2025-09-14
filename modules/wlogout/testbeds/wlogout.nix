{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "wlogout";
  };

  home-manager.sharedModules = lib.singleton {
    programs.wlogout = {
      enable = true;
    };
  };
}
