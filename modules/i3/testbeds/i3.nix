{ lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  home-manager.sharedModules = lib.singleton (
    { config, ... }:
    {
      programs.kitty.enable = true;
      xsession.windowManager.i3 = {
        enable = true;
        config = {
          startup = lib.singleton { command = "kitty"; };
          bars = lib.singleton (
            {
              mode = "dock";
              hiddenState = "hide";
              position = "bottom";
              workspaceButtons = true;
              workspaceNumbers = true;
              statusCommand = lib.getExe pkgs.i3status;
              trayOutput = "primary";
            }
            // config.stylix.targets.i3.exportedBarConfig
          );
        };
      };
    }
  );
}
