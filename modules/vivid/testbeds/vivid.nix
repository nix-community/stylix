{ lib, pkgs, ... }:
let
  package = pkgs.vivid;
in
{
  stylix.testbed.ui.command = {
    text = "${lib.getExe pkgs.lsd} --all --long --recursive flake-parts/";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.vivid = {
      enable = true;
      inherit package;
    };
  };
}
