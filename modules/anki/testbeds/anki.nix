{ lib, ... }:
{
  stylix.testbed.ui.command.text = "anki";

  home-manager.sharedModules = lib.singleton { programs.anki.enable = true; };
}
