{
  lib,
  pkgs,
  ...
}:
{
  stylix.testbed.ui.graphicalEnvironment = "hyprland";

  home-manager.sharedModules = lib.singleton {
    stylix.fonts.monospace = {
      name = "CaskaydiaCove NF";
      package = pkgs.nerd-fonts.caskaydia-cove;
    };
    programs.hyprpanel.enable = true;
  };
}
