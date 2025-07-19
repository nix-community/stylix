{ mkTarget, ... }:
mkTarget {
  name = "hyprpaper";
  humanName = "Hyprpaper";

  config =
    { image }:
    {
      services.hyprpaper.settings = {
        preload = [ "${image}" ];
        wallpaper = [ ",${image}" ];
      };
    };
}
