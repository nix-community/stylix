{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "dcal";
    sendNotifications = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.dank-calendar.enable = true;
  };
}
