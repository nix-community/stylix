{ lib, mkTarget, ... }:
mkTarget {
  options = {
    monitor = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "DP-1";
      description = ''Monitor(s) to apply the wallpaper to (`""` matches all monitors)'';
    };
  };

  config =
    { image, cfg }:
    {
      services.hyprpaper.settings = {
        wallpaper = lib.singleton {
          inherit (cfg) monitor;
          path = image;
        };
        splash = false;
      };
    };
}
