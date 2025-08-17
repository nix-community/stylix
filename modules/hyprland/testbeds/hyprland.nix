{ pkgs, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";

    # We need something to open a window so that we can check the window borders
    application = {
      name = "kitty";
      package = pkgs.kitty;
    };
  };
}
