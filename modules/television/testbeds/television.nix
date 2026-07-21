{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = "${lib.getExe pkgs.television} files flake-parts";
    useTerminal = true;
  };

  environment.systemPackages = with pkgs; [
    fd
    ripgrep
  ];

  home-manager.sharedModules = lib.singleton {
    programs = {
      bat.enable = true;
      television.enable = true;
    };
  };
}
