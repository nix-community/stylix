{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "sleep 5 && vicinae open";
  };

  home-manager.sharedModules = lib.singleton {
    programs.vicinae = {
      enable = true;
      systemd.enable = true;
    };
  };
}
