{ pkgs, ... }:
{
  stylix.testbed.ui = {
    command.packages = [ pkgs.kitty ];
    graphicalEnvironment = "hyprland";
  };
}
