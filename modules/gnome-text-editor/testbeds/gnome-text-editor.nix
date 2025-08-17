{ pkgs, ... }:
{
  stylix.testbed.ui.command.text = "gnome-text-editor flake-parts/flake.nix";
  environment.systemPackages = [ pkgs.gnome-text-editor ];
}
