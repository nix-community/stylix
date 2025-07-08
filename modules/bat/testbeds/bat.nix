{ lib, pkgs, ... }:
let
  package = pkgs.bat;
in
{
  environment = {
    loginShellInit = "${lib.getExe package} flake-parts/flake.nix";
    systemPackages = [ package ];
  };
}
