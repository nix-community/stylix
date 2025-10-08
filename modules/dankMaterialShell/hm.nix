{ mkTarget, ... }:
mkTarget {
  name = "dankMaterialShell";
  humanName = "DankMaterialShell";
  configElements = [
    (
      { colors }:
      let
        colorTheme = {
          dark = with colors.withHashtag; {
            name = "Stylix generatated dark theme";
            primary = base0D;
            primaryText = base00;
            primaryContainer = base0C;
            secondary = base0E;
            surface = base01;
            surfaceText = base05;
            surfaceVariant = base02;
            surfaceVariantText = base04;
            surfaceTint = base0D;
            background = base00;
            backgroundText = base05;
            outline = base03;
            surfaceContainer = base01;
            surfaceContainerHigh = base02;
            surfaceContainerHighest = base03;
            error = base08;
            warning = base0A;
            info = base0C;
          };

          light = with colors.withHashtag; {
            name = "Stylix generatated light theme";
            primary = base0D;
            primaryText = base07;
            primaryContainer = base0C;
            secondary = base0E;
            surface = base06;
            surfaceText = base01;
            surfaceVariant = base07;
            surfaceVariantText = base02;
            surfaceTint = base0D;
            background = base07;
            backgroundText = base00;
            outline = base04;
            surfaceContainer = base06;
            surfaceContainerHigh = base05;
            surfaceContainerHighest = base04;
            error = base08;
            warning = base0A;
            info = base0C;
          };
        };
      in
      {
        home.file.".config/DankMaterialShell/stylix-colors.json".text =
          builtins.toJSON colorTheme;
      }
    )
  ];
}
