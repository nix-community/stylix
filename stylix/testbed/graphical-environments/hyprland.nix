{
  config,
  lib,
  pkgs,
  ...
}:
{
  config =
    lib.mkIf (config.stylix.testbed.ui.graphicalEnvironment or null == "hyprland")
      {
        environment.loginShellInit = lib.getExe pkgs.hyprland;
        programs.hyprland.enable = true;
        environment.systemPackages = [
          # dex looks for `x-terminal-emulator` when running a terminal program
          (pkgs.writeShellScriptBin "x-terminal-emulator" ''exec ${lib.getExe pkgs.kitty} "$@"'')
        ];

        home-manager.sharedModules = lib.singleton {
          programs.kitty.enable = true;
          wayland.windowManager.hyprland = {
            enable = true;
            settings = {
              exec-once = "find /run/current-system/sw/etc/xdg/autostart/ -type f -or -type l | xargs -P0 -L1 ${lib.getExe pkgs.dex}";
              ecosystem = {
                no_update_news = true;
                no_donation_nag = true;
              };
            };
          };
        };
      };
}
