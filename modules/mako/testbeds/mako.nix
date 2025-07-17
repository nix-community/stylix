{ lib, pkgs, ... }:
{
  stylix.testbed.ui = {
    # We use Hyprland because Gnome has its own notification daemon
    graphicalEnvironment = "hyprland";
    command.text =
      # Run as a single command to ensure the same order between executions
      lib.concatMapStringsSep " && "
        (
          urgency: "${lib.getExe pkgs.libnotify} --urgency ${urgency} ${urgency} urgency"
        )
        [
          "low"
          "normal"
          "critical"
        ];
  };

  home-manager.sharedModules = lib.singleton {
    services.mako.enable = true;
  };
}
