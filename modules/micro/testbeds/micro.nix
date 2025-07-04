{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = "${lib.getExe pkgs.micro} example.md";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.micro.enable = true;
    home.file."example.md" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/sharkdp/bat/e2aa4bc33cca785cab8bdadffc58a4a30b245854/tests/syntax-tests/source/Markdown/example.md";
        hash = "sha256-VYYwgRFY1c2DPY7yGM8oF3zG4rtEpBWyqfPwmGZIkcA=";
      };
    };
  };
}
