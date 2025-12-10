{ lib, pkgs, ... }:
let
  package = pkgs.swayimg;
in
{
  environment = {
    loginShellInit = "${lib.getExe package} flake-parts/flake.nix";
    systemPackages = [ package ];
  };
}
