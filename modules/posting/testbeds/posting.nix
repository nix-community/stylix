{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "posting";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton { programs.posting.enable = true; };
}
