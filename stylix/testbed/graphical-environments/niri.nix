{
  config,
  lib,
  pkgs,
  ...
}:
{
  config =
    lib.mkIf (config.stylix.testbed.ui.graphicalEnvironment or null == "niri")
      {
        hardware.graphics.enable = true;
        environment.loginShellInit = ''
          if [ "$(tty)" = "/dev/tty1" ]; then
            exec ${lib.getExe' pkgs.niri "niri-session"} -l
          fi
        '';
        systemd.user.services.niri.enableDefaultPath = false;
        programs.niri.enable = true;

        environment.systemPackages = [
          (pkgs.writeShellScriptBin "x-terminal-emulator" ''exec ${lib.getExe pkgs.kitty} "$@"'')
        ];

        home-manager.sharedModules = lib.singleton (
          { config, ... }: {
            programs.kitty.enable = true;

            wayland.windowManager.niri = {
              enable = true;
              settings = {
                _children = [
                  {
                    spawn-at-startup._args = [
                      "${pkgs.bash}/bin/bash"
                      "-c"
                      "find /run/current-system/sw/etc/xdg/autostart/ -type f -or -type l | xargs -P0 -L1 ${lib.getExe pkgs.dex}"
                    ];
                  }
                ];
              };
            };
          }
        );

        # Enable 3D acceleration for the VM testbed specifically for Niri
        virtualisation.vmVariant = {
          virtualisation = {
            graphics = true;
            qemu.options = [
              "-device virtio-vga-gl"
              "-display gtk,gl=on"
            ];
          };
        };
      };
}
