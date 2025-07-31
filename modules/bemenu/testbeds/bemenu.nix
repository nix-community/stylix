{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "bemenu";
  };

  home-manager.sharedModules = lib.singleton {
    programs = {
      bash.enable = true;
      bemenu.enable = true;
    };
  };
}
