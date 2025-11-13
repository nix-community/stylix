{
  config,
  lib,
  pkgs,
  ...
}:
{
  config =
    lib.mkIf (config.stylix.testbed.ui.graphicalEnvironment or null == "bspwm")
      {
        services.xserver = {
          enable = true;
          windowManager.bspwm.enable = true;
        };

        environment.systemPackages = [
          # dex looks for `x-terminal-emulator` when running a terminal program
          (pkgs.writeShellScriptBin "x-terminal-emulator" ''exec ${lib.getExe pkgs.kitty} "$@"'')
        ];

        home-manager.sharedModules = lib.singleton {
          programs.kitty.enable = true;
          xsession.windowManager.bspwm = {
            enable = true;
            startupPrograms = [
              "find /run/current-system/sw/etc/xdg/autostart/ -type f -or -type l | xargs -P0 -L1 ${lib.getExe pkgs.dex}"
            ];
          };
        };
      };
}
