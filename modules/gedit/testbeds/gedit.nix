{ pkgs, ... }:
{
  stylix.testbed.ui.command = {
    packages = [ pkgs.gedit ];
    text = "gedit flake-parts/flake.nix";
  };
}
