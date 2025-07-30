{ lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "bash";
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs = {
      bash.enable = true;

      starship = {
        enable = true;
        enableBashIntegration = true;
      };
    };
  };
}
