{ mkTarget, ... }:
mkTarget {
  name = "Limine";
  humanName = "Limine";

  configElements =
    { colors }:
    {
      boot.loader.limine = {
        extraConfig = with colors; ''
          term_palette: ${base05};${base08};${base0B};${base0A};${base0D};${base0E};${base0C};${base00}
          term_palette_bright: ${base00};${base08};${base0B};${base0A};${base0D};${base0E};${base0C};${base05}
          term_background: ${base00}
          term_foreground: ${base05}
          term_background_bright: ${base05}
          term_foreground_bright: ${base0A}
        '';
        style.wallpapers = [ ];
      };
    };
}
