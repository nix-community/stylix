{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.stylix.fonts;

  # AppKit uses points as logical user space units, with the backing scale
  # applied separately. Pango uses a 96 DPI baseline by default, so 12 points
  # correspond to 16 logical device units.
  pointScale =
    if pkgs.stdenv.hostPlatform.isDarwin or false then 1.0 else 3.0 / 4.0;

  mkFontOptions =
    {
      fontName,
      displayName,
      package,
    }:
    {
      package = lib.mkPackageOption pkgs package { } // {
        description = "Package providing the ${displayName} font.";
      };

      name = lib.mkOption {
        type = lib.types.str;
        description = "Name of the ${displayName} font.";
        default = fontName;
      };
    };
in
{
  options.stylix.fonts = {
    serif = mkFontOptions {
      displayName = "Serif";
      fontName = "DejaVu Serif";
      package = "dejavu_fonts";
    };

    sansSerif = mkFontOptions {
      displayName = "Sans-serif";
      fontName = "DejaVu Sans";
      package = "dejavu_fonts";
    };

    monospace = mkFontOptions {
      displayName = "Monospace";
      fontName = "DejaVu Sans Mono";
      package = "dejavu_fonts";
    };

    emoji = mkFontOptions {
      displayName = "Emoji";
      fontName = "Noto Color Emoji";
      package = "noto-fonts-color-emoji";
    };

    sizes =
      let
        mkFontSizeOption =
          {
            default,
            target,
            defaultText ? default * 4.0 / 3.0,
          }:
          let
            sizeType = lib.types.submodule (
              { config, ... }: {
                options = {
                  px = lib.mkOption {
                    description = ''
                      Font size in CSS reference pixels.

                      This is the canonical, user-configurable value.
                    '';
                    type = with lib.types; either ints.unsigned float;
                    default = default * 4.0 / 3.0;
                    inherit defaultText;
                  };

                  pt = lib.mkOption {
                    description = ''
                      Platform adjusted point size corresponding to `px`.

                      This uses the native 1:1 point baseline on Darwin and
                      the conventional 72/96 conversion elsewhere. Display
                      scaling remains the responsibility of the application
                      and platform.
                    '';
                    type = lib.types.float;
                    readOnly = true;
                    default = config.px * pointScale;
                  };

                  rounded = {
                    px = lib.mkOption {
                      description = "`px` rounded to the nearest integer.";
                      type = lib.types.ints.unsigned;
                      readOnly = true;
                      default = builtins.floor (config.px + 0.5);
                    };

                    pt = lib.mkOption {
                      description = "`pt` rounded to the nearest integer.";
                      type = lib.types.ints.unsigned;
                      readOnly = true;
                      default = builtins.floor (config.pt + 0.5);
                    };
                  };
                };
              }
            );
          in
          lib.mkOption {
            description = ''
              The font size used for ${target}.

              Sizes are configured in CSS reference pixels. The CSS
              specification fixes one inch at 96 reference pixels and one
              point at 1/72nd of an inch. Native point based applications use
              different logical baselines across platforms, so Stylix adjusts
              the point value to preserve the same logical size: 1:1 on
              Darwin and 72/96 elsewhere.

              This does not describe physical screen pixels or replace an
              application's display scaling. Applications should continue to
              use their native DPI and per display scaling behaviour.

              The previous scalar syntax is accepted and converted from the
              historical point based scale for backwards compatibility. New
              configurations should set `px`.
            '';
            type = lib.types.coercedTo (with lib.types; either ints.unsigned float) (pt: {
              px = pt * 4.0 / 3.0;
            }) sizeType;
          };
      in
      {
        desktop = mkFontSizeOption {
          target = "window titles, status bars, and other general elements of the desktop";
          default = 10;
        };

        applications = mkFontSizeOption {
          target = "applications";
          default = 12;
        };

        terminal = mkFontSizeOption {
          target = "terminals and text editors";
          default = 12;
          defaultText = lib.literalExpression "config.stylix.fonts.sizes.applications.px";
        };

        popups = mkFontSizeOption {
          target = "notifications, popups, and other overlay elements of the desktop";
          default = 10;
          defaultText = lib.literalExpression "config.stylix.fonts.sizes.desktop.px";
        };
      };

    packages = lib.mkOption {
      description = ''
        A list of all the font packages that will be installed.
      '';
      type = lib.types.listOf lib.types.package;
      readOnly = true;
    };
  };

  config = lib.mkMerge [
    {
      # The fallback must lose to a NixOS value forwarded into Home Manager
      # with `mkDefault`, while still overriding the static option default.
      stylix.fonts.sizes.terminal.px = lib.mkOverride 1001 cfg.sizes.applications.px;
      stylix.fonts.sizes.popups.px = lib.mkOverride 1001 cfg.sizes.desktop.px;
    }
    (lib.mkIf config.stylix.enable {
      stylix.fonts.packages = [
        cfg.monospace.package
        cfg.serif.package
        cfg.sansSerif.package
        cfg.emoji.package
      ];
    })
  ];
}
