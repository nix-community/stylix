{ pkgs, ... }:
{
  stylix.testbed.ui.command = {
    packages = [ pkgs.gnome-text-editor ];
    text = "gnome-text-editor flake-parts/flake.nix";
  };
}
