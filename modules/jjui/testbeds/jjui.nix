{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = ''
      cd $(mktemp -d)
      ${lib.getExe pkgs.jujutsu} git init
      ${lib.getExe pkgs.jjui}
    '';
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.jujutsu.enable = true;
    programs.jjui.enable = true;
  };
}
