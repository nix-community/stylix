{ lib, ... }:
{
  stylix.testbed.ui.command.text = "ghostty";

  home-manager.sharedModules = lib.singleton {
    programs.ghostty.enable = true;
  };
}
