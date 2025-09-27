{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
  };

  home-manager.sharedModules = lib.singleton {
    programs.hyprpanel = {
      enable = true;
    };
  };
}
