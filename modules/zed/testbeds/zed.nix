{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = "${lib.getExe pkgs.zed-editor} flake-parts/flake.nix";
  };

  home-manager.sharedModules = lib.singleton {
    programs.zed-editor.enable = true;
  };
}
