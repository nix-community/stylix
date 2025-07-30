{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "git init && lazygit";
  };

  home-manager.sharedModules = lib.singleton {
    programs = {
      git.enable = true;
      lazygit.enable = true;
    };
  };
}
