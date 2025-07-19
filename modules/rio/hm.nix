# Documentation is available at:
# - https://raphamorim.io/rio/docs/config
{ mkTarget, ... }:
mkTarget {
  config = [
    (
      { fonts }:
      {
        programs.rio.settings.fonts = with fonts; {
          family = monospace.name;
          emoji.family = emoji.name;
          # converting font size to px
          size = sizes.terminal * 4.0 / 3.0;
        };
      }
    )
    (
      { opacity }:
      {
        programs.rio.settings.window.opacity = opacity.terminal;
      }
    )
    (
      { colors }:
      {
        programs.rio.settings.colors = with colors.withHashtag; {
          selection-background = base02;
          selection-foreground = base05;
          cursor = base05;
          tabs = base01;
          tabs-active = base02;
          background = base00;
          foreground = base05;
          black = base01;
          red = base08;
          yellow = base0A;
          green = base0B;
          cyan = base0C;
          blue = base0D;
          magenta = base0E;
          white = base06;
          dim-foreground = base05;
          dim-black = base01;
          dim-red = base08;
          dim-yellow = base0A;
          dim-green = base0B;
          dim-cyan = base0C;
          dim-blue = base0D;
          dim-magenta = base0E;
          dim-white = base04;
          light-foreground = base05;
          light-black = base02;
          light-red = base08;
          light-yellow = base0A;
          light-green = base0B;
          light-cyan = base0C;
          light-blue = base0D;
          light-magenta = base0E;
          light-white = base07;
        };
      }
    )
  ];
}
