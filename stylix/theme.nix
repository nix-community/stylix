{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.stylix;

  themeOptions = {
    wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      apply =
        value: if value == null || lib.isDerivation value then value else "${value}";
      description = ''
        Wallpaper image for this theme modality.
      '';
    };

    base16Scheme = lib.mkOption {
      type =
        with lib.types;
        nullOr (oneOf [
          path
          lines
          attrs
        ]);
      default = null;
      description = ''
        A scheme following the base16 standard for this theme modality.
      '';
    };

    icons = {
      package = lib.mkOption {
        type = lib.types.nullOr lib.types.package;
        default = null;
        description = ''
          Package providing the icon theme for this modality.
        '';
      };
      name = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          Icon theme name for this modality.
        '';
      };
    };

    cursor = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "The cursor name within the package.";
            };
            package = lib.mkOption {
              type = lib.types.package;
              description = "Package providing the cursor theme.";
            };
            size = lib.mkOption {
              type = lib.types.int;
              description = "The cursor size.";
            };
          };
        }
      );
      default = null;
      description = ''
        Cursor configuration for this theme modality.
      '';
    };
  };

  # Helper to determine if theme modalities are configured
  hasThemeConfig = cfg.theme.light != null || cfg.theme.dark != null;

  # Get single theme for apps that don't support switching
  # Prioritizes: defaultTheme > polarity
  singleTheme =
    let
      preference =
        if cfg.defaultTheme != null then cfg.defaultTheme else cfg.polarity;
      # When only one theme is configured, use it regardless of preference
      fallbackTheme =
        if cfg.theme.dark != null then cfg.theme.dark else cfg.theme.light;
    in
    if preference == "light" then
      if cfg.theme.light != null then cfg.theme.light else fallbackTheme
    else if preference == "dark" then
      if cfg.theme.dark != null then cfg.theme.dark else fallbackTheme
    else
      # "either" - no strong preference, default to dark if available
      fallbackTheme;

  # Computed theme configurations (for modules to access)
  computedLightTheme =
    if cfg.theme.light != null then cfg.theme.light else cfg.theme.dark;
  computedDarkTheme =
    if cfg.theme.dark != null then cfg.theme.dark else cfg.theme.light;
in
{
  options.stylix = {
    theme = {
      light = lib.mkOption {
        type = lib.types.nullOr (lib.types.submodule { options = themeOptions; });
        default = null;
        description = ''
          Light theme configuration.

          If only this is set (dark is null), these settings will be used for both modalities.
        '';
      };

      dark = lib.mkOption {
        type = lib.types.nullOr (lib.types.submodule { options = themeOptions; });
        default = null;
        description = ''
          Dark theme configuration.

          If only this is set (light is null), these settings will be used for both modalities.
        '';
      };
    };

    defaultTheme = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "light"
          "dark"
        ]
      );
      default = null;
      description = ''
        Which theme to use for applications that don't support automatic theme switching.

        When set, this takes precedence over the polarity setting.
        Use this instead of polarity when using theme modalities.

        - "light": Use light theme for single-theme applications
        - "dark": Use dark theme for single-theme applications
        - null: Fall back to polarity setting

        Note: Applications that support both themes (like GTK, Qt, Ghostty) will always
        get both themes configured regardless of this setting.
      '';
    };

    # Internal options to expose computed themes
    _computedThemes = lib.mkOption {
      type = lib.types.attrs;
      internal = true;
      readOnly = true;
      default = {
        inherit hasThemeConfig singleTheme;
        light = computedLightTheme;
        dark = computedDarkTheme;
      };
      description = ''
        The computed theme configurations for both modalities.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # When theme modalities are configured, map them to the legacy options
    # For single-theme applications/settings, use singleTheme (defaultTheme > polarity)
    stylix = lib.mkMerge [
      # Wallpaper - single selection
      (lib.mkIf (hasThemeConfig && singleTheme.wallpaper != null) {
        image = lib.mkForce singleTheme.wallpaper;
      })

      # Base16 scheme - single selection
      (lib.mkIf (hasThemeConfig && singleTheme.base16Scheme != null) {
        base16Scheme = lib.mkForce singleTheme.base16Scheme;
      })

      # Icons - provide both light and dark when available
      (lib.mkIf hasThemeConfig {
        icons = {
          package = lib.mkForce (
            if computedLightTheme != null then
              computedLightTheme.icons.package
            else if computedDarkTheme != null then
              computedDarkTheme.icons.package
            else
              null
          );
          light = lib.mkForce (
            if computedLightTheme != null then computedLightTheme.icons.name else null
          );
          dark = lib.mkForce (
            if computedDarkTheme != null then computedDarkTheme.icons.name else null
          );
        };
      })

      # Cursor - single selection (most cursor systems don't support dual themes)
      (lib.mkIf (hasThemeConfig && singleTheme.cursor != null) {
        cursor = lib.mkForce singleTheme.cursor;
      })
    ];
  };
}
