{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = "${lib.getExe pkgs.zed-editor} example.md";
  };

  home-manager.sharedModules = lib.singleton {
    programs.zed-editor.enable = true;
    home.file."example.md" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/sharkdp/bat/e2aa4bc33cca785cab8bdadffc58a4a30b245854/tests/syntax-tests/source/Rust/output.rs";
        hash = "sha256-vpUndD6H1oJfYVDai4LpVpsW6SSGbK466t3IKENZ1ow=";
      };
    };
  };
}
