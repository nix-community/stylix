{ lib, pkgs, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    hyprland.configType = "hyprlang";

    # We need something to open a window so that we can check the window borders
    application = {
      name = "kitty";
      package = pkgs.kitty;
    };
  };
  home-manager.sharedModules = lib.singleton {
    wayland.windowManager.hyprland = {
      configType = "hyprlang";
    };
  };
}
