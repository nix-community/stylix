{ pkgs, ... }:
{
  stylix.testbed.ui.command.text = "gedit flake-parts/flake.nix";
  environment.systemPackages = [ pkgs.gedit ];
}
