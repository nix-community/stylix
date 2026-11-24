{
  mkTarget,
  lib,
  pkgs,
  config,
  ...
}:
let
  wallpaper = import ./wallpaper.nix { inherit lib pkgs; };
in
mkTarget {
  imports = wallpaper.renamedOptions;

  options.wallpaper.enable = config.lib.stylix.mkEnableTargetWith {
    name = "X11 wallpaper (via feh)";
    autoEnable =
      with config.services.xserver.windowManager;
      xmonad.enable || i3.enable;
    autoEnableExpr = ''
      with config.services.xserver.windowManager;
      xmonad.enable || i3.enable
    '';
  };

  config =
    {
      cfg,
      image,
      imageScalingMode,
    }:
    lib.mkIf cfg.wallpaper.enable {
      services.xserver.displayManager.sessionCommands = wallpaper.mkCommand {
        inherit image imageScalingMode;
      };
    };
}
