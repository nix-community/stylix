{ mkTarget, ... }:
mkTarget {
  name = "Limine";
  humanName = "Limine";

  configElements =
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
        wallpapers = [ ];
      };
    };
}
