{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = ''
      cd "$(mktemp --directory)"

      jj git init
      jjui
    '';
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs = {
      jujutsu.enable = true;
      jjui.enable = true;
    };
  };
}
