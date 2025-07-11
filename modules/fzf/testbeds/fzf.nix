{ lib, pkgs, ... }:
{
  stylix.testbed.ui.command = {
    text = pkgs.fzf;
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs = {
      bash.enable = true;
      fzf.enable = true;
    };
  };
}
