{
  pkgs,
  lib,
  ...
}:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
  };

  home-manager.sharedModules = lib.singleton {
    home.packages = with pkgs; [
      nerd-fonts.caskaydia-cove
    ];

    programs.hyprpanel = {
      enable = true;

      settings.theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };
}
