{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "fish";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton { programs.fish.enable = true; };
}
