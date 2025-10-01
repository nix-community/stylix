{
  lib,
  pkgs,
  ...
}:
{
  stylix.testbed.ui.graphicalEnvironment = "hyprland";

  home-manager.sharedModules = lib.singleton {
    stylix.fonts.monospace = {
      name = "FiraMono NF";
      package = pkgs.nerd-fonts.fira-mono;
    };
    programs.hyprpanel.enable = true;
  };
}
