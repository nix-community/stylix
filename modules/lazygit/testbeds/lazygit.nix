{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "git init && lazygit";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs = {
      git.enable = true;
      lazygit.enable = true;
    };
  };
}
