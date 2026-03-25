{
  lib,
  mkTarget,
  ...
}:
mkTarget {
  options = {
    monitor = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Monitor to apply the wallpaper to (\"\" matches all monitors). Example: \"DP-1\"";
    };
  };
  config = {
    image,
    cfg,
  }: {
    services.hyprpaper.settings = {
      wallpaper = lib.singleton {
        monitor = cfg.monitor;
        path = image;
      };
      splash = false;
    };
  };
}
