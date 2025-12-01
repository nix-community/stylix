{ lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "bash";
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
