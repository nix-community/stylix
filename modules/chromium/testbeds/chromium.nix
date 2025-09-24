{ lib, ... }:
{
  stylix.testbed.ui.command.text = "chromium";

  home-manager.sharedModules = lib.singleton {
    programs.chromium.enable = true;
  };
}
