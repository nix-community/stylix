{ mkTarget, lib, ... }:
mkTarget {
  imports = [
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "limine"
        "useWallpaper"
      ];
      sinceRelease = 2605;
      to = [
        "stylix"
        "targets"
        "limine"
        "image"
        "enable"
      ];
    })
  ];

  config = [
    (
      { colors }:
      {
        boot.loader.limine.style = with colors; {
          graphicalTerminal = {
            palette = "${base05};${base08};${base0B};${base0A};${base0D};${base0E};${base0C};${base00}";
            brightPalette = "${base00};${base08};${base0B};${base0A};${base0D};${base0E};${base0C};${base05}";
            background = base00;
            foreground = base05;
            brightBackground = base05;
            brightForeground = base0A;
          };
          backdrop = base00;
        };
      }
    )
    (
      { image }:
      {
        boot.loader.limine.style.wallpapers = [ image ];
      }
    )
    (
      { imageScalingMode }:
      {
        # Stylix supports more scaling modes than limine supports.
        boot.loader.limine.style.wallpaperStyle =
          {
            "stretch" = "stretched";
            "fill" = "stretched";
            "fit" = "stretched";
            "center" = "centered";
            "tile" = "tiled";
            inherit null;
          }
          .${imageScalingMode};
      }
    )
  ];
}
