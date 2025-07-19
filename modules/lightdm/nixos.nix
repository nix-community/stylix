{
  mkTarget,
  config,
  lib,
  ...
}:
mkTarget {
  options.useWallpaper = config.lib.stylix.mkEnableWallpaper "LightDM" true;

  config =
    { cfg, image }:
    {
      services.xserver.displayManager.lightdm.background =
        lib.mkIf cfg.useWallpaper image;
    };
}
