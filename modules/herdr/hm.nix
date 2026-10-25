{ mkTarget, ... }:
mkTarget {
  config = { colors }: {
    programs.herdr.settings.theme.custom = with colors.withHashtag; {
      accent = base0D;

      panel_bg = base00;
      surface_dim = base01;
      surface0 = base02;
      surface1 = base03;

      overlay0 = base03;
      overlay1 = base04;
      subtext0 = base04;
      text = base05;

      red = base08;
      peach = base09;
      yellow = base0A;
      green = base0B;
      teal = base0C;
      blue = base0D;
      mauve = base0E;
    };
  };
}
