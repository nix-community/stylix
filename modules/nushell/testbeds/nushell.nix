{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "nu";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton { programs.nushell.enable = true; };
}
