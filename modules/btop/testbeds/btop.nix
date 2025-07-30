{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "btop";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.btop.enable = true;
  };
}
