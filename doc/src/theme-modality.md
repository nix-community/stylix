# Theme Modality Support

Stylix now supports configuring separate light and dark themes that can be used by applications that support automatic theme switching based on system preferences.

## Basic Configuration

You can configure both light and dark themes:

```nix
{
  stylix = {
    enable = true;

    theme = {
      light = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-light.yaml";
        wallpaper = ./wallpaper-light.jpg;
        icons = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Light";
        };
      };

      dark = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
        wallpaper = ./wallpaper-dark.jpg;
        icons = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
        };
      };
    };

    # For applications that don't support theme switching
    defaultTheme = "dark"; # or "light"
  };
}
```

## Application Support

Applications are categorized into two groups:

1. **Theme-aware applications** (like Ghostty, GTK, Qt): These will receive both light and dark theme configurations and can switch between them automatically.

2. **Single-theme applications**: These will use the theme specified by `defaultTheme` (or fall back to `polarity` if not set).

## Backward Compatibility

The new theme modality system is fully backward compatible:

- If you don't configure `theme.light` or `theme.dark`, the existing `base16Scheme`, `image`, and other options continue to work as before
- The `polarity` option is still respected when `defaultTheme` is not set
- You can configure just one theme modality (e.g., only `theme.dark`) and it will be used for both light and dark modes

## Migration Guide

To migrate from the old configuration to theme modalities:

### Before:
```nix
{
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
    image = ./wallpaper.jpg;
    polarity = "dark";
  };
}
```

### After:
```nix
{
  stylix = {
    theme.dark = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
      wallpaper = ./wallpaper.jpg;
    };
    defaultTheme = "dark";
  };
}
```

Or keep both configurations during transition:
```nix
{
  stylix = {
    # Legacy configuration (used as fallback)
    base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
    image = ./wallpaper.jpg;

    # New theme modality (takes precedence)
    theme = {
      light = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-light.yaml";
        wallpaper = ./wallpaper-light.jpg;
      };
      dark = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
        wallpaper = ./wallpaper-dark.jpg;
      };
    };
    defaultTheme = "dark";
  };
}
```
