{ lib, ... }:
{
  stylix.testbed.ui.command.text = "vesktop";

  home-manager.sharedModules = lib.singleton {
    programs.vesktop.enable = true;
  };
}
