# Documentation is available at:
# - https://ghostty.org/docs/config/reference
# - `man 5 ghostty`
{
  mkTarget,
  lib,
  ...
}:
mkTarget {
  name = "ghostty";
  humanName = "Ghostty";

  configElements = [
    (
      { fonts }:
      {
        programs.ghostty.settings = {
          font-family = [
            fonts.monospace.name
            fonts.emoji.name
          ];
          font-size = fonts.sizes.terminal;
        };
      }
    )
    (
      { opacity }:
      {
        programs.ghostty.settings = {
          background-opacity = opacity.terminal;
        };
      }
    )
    (
      {
        colors,
        base16,
        override ? { },
        _computedThemes ? { },
      }:
      let
        # Helper to create a theme from a color scheme
        makeTheme = scheme: {
          background = scheme.base00;
          foreground = scheme.base05;
          cursor-color = scheme.base05;
          selection-background = scheme.base02;
          selection-foreground = scheme.base05;

          palette = with scheme.withHashtag; [
            "0=${base00}"
            "1=${base08}"
            "2=${base0B}"
            "3=${base0A}"
            "4=${base0D}"
            "5=${base0E}"
            "6=${base0C}"
            "7=${base05}"
            "8=${base03}"
            "9=${base08}"
            "10=${base0B}"
            "11=${base0A}"
            "12=${base0D}"
            "13=${base0E}"
            "14=${base0C}"
            "15=${base07}"
          ];
        };

        # Check if we have theme modalities configured
        hasThemeConfig = _computedThemes.hasThemeConfig or false;

        # Get both light and dark color schemes if available
        lightColors =
          if hasThemeConfig && _computedThemes.light.base16Scheme != null then
            (base16.mkSchemeAttrs _computedThemes.light.base16Scheme).override override
          else
            colors;

        darkColors =
          if hasThemeConfig && _computedThemes.dark.base16Scheme != null then
            (base16.mkSchemeAttrs _computedThemes.dark.base16Scheme).override override
          else
            colors;

        # Check if we actually have different light and dark themes
        hasDifferentThemes =
          hasThemeConfig
          && _computedThemes.light.base16Scheme != null
          && _computedThemes.dark.base16Scheme != null;
      in
      {
        programs.ghostty = lib.mkMerge [
          # If we have different light and dark themes, configure both
          # Ghostty supports auto-switching, so we always provide both themes
          (lib.mkIf hasDifferentThemes {
            settings.theme = "dark:stylix-dark,light:stylix-light";
            themes = {
              stylix-dark = makeTheme darkColors;
              stylix-light = makeTheme lightColors;
            };
          })

          # Single theme configuration (legacy or when only one modality is configured)
          (lib.mkIf (!hasDifferentThemes) {
            settings.theme = "stylix";
            themes.stylix = makeTheme colors;
          })
        ];
      }
    )
  ];
}
