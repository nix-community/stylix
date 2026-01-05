{ mkTarget, ... }:
mkTarget {
  config =
    { image }:
    {
      services.hyprpaper.settings = {
        preload = [ "${image}" ];
        wallpaper = [ ",${image}" ];
      };
    };
}
