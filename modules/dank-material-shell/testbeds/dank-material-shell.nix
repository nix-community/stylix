{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "dms run";
    sendNotifications = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.dank-material-shell.enable = true;
  };
}
