{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "dms run";
  };

  home-manager.sharedModules = lib.singleton {
    programs.dank-material-shell.enable = true;
  };
}
