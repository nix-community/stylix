{ mkTarget, ... }:
mkTarget {
  config = [
    (
      { fonts }:
      {
        services.wayle.settings.general = {
          font-sans = fonts.sansSerif.name;
          font-mono = fonts.monospace.name;
        };
      }
    )
    (
      { colors }:
      {
        services.wayle.settings.styling.palette = with colors.withHashtag; {
          bg = base00;
          surface = base01;
          elevated = base02;
          fg = base05;
          fg-muted = base04;
          primary = base0D;
          red = base08;
          yellow = base0A;
          green = base0B;
          blue = base0D;
        };
      }
    )
    (
      { opacity }:
      {
        services.wayle.settings.bar.background-opacity = builtins.floor (
          opacity.desktop * 100
        );
      }
    )
  ];
}
