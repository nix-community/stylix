{ lib, ... }:
{
  stylix.testbed.ui.command.text = "wezterm";

  home-manager.sharedModules = lib.singleton {
    programs.wezterm.enable = true;
  };
}
