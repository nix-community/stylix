{ lib, pkgs, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    hyprland.configType = "lua";

    # We need something to open a window so that we can check the window borders
    application = {
      name = "kitty";
      package = pkgs.kitty;
    };
  };
}
