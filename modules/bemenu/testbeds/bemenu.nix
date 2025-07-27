{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "bemenu";
  };

  home-manager.sharedModules = lib.singleton {
    programs.bemenu.enable = true;
  };
}
