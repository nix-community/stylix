{ mkTarget, ... }:
mkTarget {
  name = "xresources";
  humanName = "Xresources";

  configElements = [
    (
      { fonts }:
      {
        xresources.properties = {
          "*.faceName" = fonts.monospace.name;
          "*.faceSize" = toString fonts.sizes.terminal;
          "*.renderFont" = true;
        };
      }
    )
    (
      { colors }:
      {
        xresources.properties = with colors.withHashtag; {
          "*foreground" = base05;
          "*background" = base00;
          "*cursorColor" = base05;
          "*color0" = base00;
          "*color1" = base08;
          "*color2" = base0B;
          "*color3" = base0A;
          "*color4" = base0D;
          "*color5" = base0E;
          "*color6" = base0C;
          "*color7" = base05;
          "*color8" = base02;
          "*color9" = base08;
          "*color10" = base0B;
          "*color11" = base0A;
          "*color12" = base0D;
          "*color13" = base0E;
          "*color14" = base0C;
          "*color15" = base07;
          "*color16" = base09;
          "*color17" = base0F;
          "*color18" = base01;
          "*color19" = base02;
          "*color20" = base04;
          "*color21" = base06;
        };
      }
    )
  ];
}
