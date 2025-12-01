{ lib, ... }:
{
  stylix.testbed.ui.command.text = "zeditor flake-parts/flake.nix";

  home-manager.sharedModules = lib.singleton {
    programs.zed-editor.enable = true;
  };
}
