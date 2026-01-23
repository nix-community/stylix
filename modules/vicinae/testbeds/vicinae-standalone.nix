{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "sleep 5 && vicinae open";
  };

  home-manager.sharedModules = lib.singleton {
    services.vicinae = {
      enable = true;
      systemd.enable = true;
    };
  };
}
