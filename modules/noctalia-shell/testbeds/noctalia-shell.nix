{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "noctalia-shell";
  };

  home-manager.sharedModules = lib.singleton {
    programs.noctalia-shell.enable = true;
  };
}
