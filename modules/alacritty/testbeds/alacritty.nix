{ lib, ... }:
{
  stylix.testbed.ui.command.text = "alacritty";

  home-manager.sharedModules = lib.singleton {
    programs.alacritty.enable = true;
  };
}
