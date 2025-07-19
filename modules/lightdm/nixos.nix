{
  mkTarget,
  config,
  lib,
  ...
}:
mkTarget {
  name = "lightdm";
  humanName = "LightDM";

  options.useWallpaper = config.lib.stylix.mkEnableWallpaper "LightDM" true;

  config =
    { cfg, image }:
    {
      services.xserver.displayManager.lightdm.background =
        lib.mkIf cfg.useWallpaper image;
    };
}
