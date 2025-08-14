{ lib, ... }:
{
  stylix.testbed.ui.command.text = "foliate";

  home-manager.sharedModules = lib.singleton {
    programs.foliate.enable = true;
  };
}
