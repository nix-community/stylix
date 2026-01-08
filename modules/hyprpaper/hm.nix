{ lib, mkTarget, ... }:
mkTarget {
  config =
    { image }:
    {
      services.hyprpaper.settings.wallpaper = lib.singleton {
        monitor = "";
        path = toString image;
      };
    };
}
