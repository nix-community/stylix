{ lib, pkgs, ... }:
let
  package = pkgs.lsd;
in
{
  environment = {
    loginShellInit = "${lib.getExe package} flake-parts/flake.nix";
    systemPackages = [ package ];
  };
}
