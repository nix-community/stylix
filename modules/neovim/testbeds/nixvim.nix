{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = "nvim example.md";
    useTerminal = true;
  };

  programs.nixvim.enable = true;

  home-manager.sharedModules = lib.singleton {
    home.file."example.md" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/sharkdp/bat/refs/heads/master/tests/syntax-tests/source/Markdown/example.md";
        hash = "sha256-VYYwgRFY1c2DPY7yGM8oF3zG4rtEpBWyqfPwmGZIkcA=";
      };
    };
  };
}
