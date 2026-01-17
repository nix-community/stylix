{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "noctalia-shell --no-duplicate";
  };

  home-manager.sharedModules = lib.singleton {
    programs.noctalia-shell.enable = true;
  };
}
