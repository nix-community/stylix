{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "ncspot";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.ncspot.enable = true;
  };
}
