{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "waybar";
  };

  home-manager.sharedModules = lib.singleton {
    programs.waybar = {
      enable = true;
      settings = lib.singleton {
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
          "custom/media"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "mpd"
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "power-profiles-daemon"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "keyboard-state"
          "hyprland/language"
          "battery"
          "battery#bat2"
          "clock"
          "tray"
          "custom/power"
        ];
      };
    };
  };
}
