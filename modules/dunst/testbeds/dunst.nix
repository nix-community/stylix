{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    sendNotifications = true;
  };

  home-manager.sharedModules = lib.singleton {
    services.dunst.enable = true;
  };
}
