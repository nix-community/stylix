{ lib, ... }:
{
  stylix.testbed.ui.command.text = "qutebrowser";

  home-manager.sharedModules = lib.singleton {
    programs.qutebrowser.enable = true;
  };
}
