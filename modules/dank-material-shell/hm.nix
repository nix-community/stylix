{
  mkTarget,
  lib,
  options,
  pkgs,
  ...
}:
mkTarget {
  options =
    let
      accents = [
        "base08"
        "base09"
        "base0A"
        "base0B"
        "base0C"
        "base0D"
        "base0E"
        "base0F"
      ];
    in
    {
      primary = lib.mkOption {
        type = lib.types.enum accents;
        default = "base0D";
        example = "base0E";
        description = ''
          Base16 color used for the `primary` and `surfaceTint` theme colors.
        '';
      };

      secondary = lib.mkOption {
        type = lib.types.enum accents;
        default = "base0E";
        example = "base0D";
        description = ''
          Base16 color used for the `secondary` theme color.
        '';
      };
    };

  config = lib.optionals (options.programs ? dank-material-shell) [
    ({ fonts }: {
      programs.dank-material-shell.settings = {
        fontFamily = fonts.sansSerif.name;
        monoFontFamily = fonts.monospace.name;
      };
    })
    ({ opacity }: {
      programs.dank-material-shell.settings = {
        popupTransparency = opacity.popups;
        dockTransparency = opacity.desktop;
      };
    })
    ({ image }: {
      programs.dank-material-shell.session = {
        wallpaperPath = image;
        wallpaperPathLight = image;
        wallpaperPathDark = image;
      };
    })
    ({ cfg, colors }: {
      programs.dank-material-shell.settings = {
        currentThemeName = "custom";
        customThemeFile =
          let
            theme = with colors.withHashtag; {
              name = "Stylix";
              primary = colors.withHashtag.${cfg.primary};
              primaryText = base00;
              primaryContainer = base0C;
              secondary = colors.withHashtag.${cfg.secondary};
              surface = base01;
              surfaceText = base05;
              surfaceVariant = base02;
              surfaceVariantText = base04;
              surfaceTint = colors.withHashtag.${cfg.primary};
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
          in
          pkgs.writeText "dankMaterialShell-stylix-color-theme.json" (
            builtins.toJSON {
              dark = theme;
              light = theme;
            }
          );
      };
    })
  ];
}
