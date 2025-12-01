{ lib, ... }:
{
  stylix.testbed.ui = {
    command.text = "sleep 5 && vicinae open";
    graphicalEnvironment = "hyprland";
  };

  home-manager.sharedModules = lib.singleton {
    services.vicinae.enable = true;
  };
}
