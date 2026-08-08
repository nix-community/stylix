{ mkTarget, lib, ... }:
mkTarget {
  options = {
    dev.enable = lib.mkEnableOption "installing the theme for the Feishin development build (`~/.config/feishin-dev`) in addition to the stable build";
  };

  config =
    {
      colors,
      cfg,
      polarity,
    }:
    let
      inherit (colors) withHashtag;

      mode = if polarity == "light" then "light" else "dark";

      themeJson = builtins.toJSON {
        extends = if mode == "light" then "ayuLight" else "tokyoNight";
        inherit mode;

        colors = {
          background = withHashtag.base00;
          background-alternate = withHashtag.base01;
          surface = withHashtag.base01;
          surface-foreground = withHashtag.base06;
          foreground = withHashtag.base05;
          foreground-muted = withHashtag.base03;

          primary = withHashtag.base0D;

          state-info = withHashtag.base0D;
          state-success = withHashtag.base0B;
          state-warning = withHashtag.base0A;
          state-error = withHashtag.base08;

          black = withHashtag.base00;
          white = withHashtag.base07;
        };

        app = {
          overlay-header = "linear-gradient(transparent 0%, ${withHashtag.base00}D9 100%), var(--theme-background-noise)";
          overlay-subheader = "linear-gradient(180deg, ${withHashtag.base00}0D 0%, var(--theme-colors-background) 100%), var(--theme-background-noise)";
          scrollbar-handle-background = "${withHashtag.base0D}33";
          scrollbar-handle-hover-background = "${withHashtag.base0D}66";
        };

        stylesheets = [ "stylix.css" ];
      };

      themeCss = ''
        [data-theme="stylix"] ::selection {
          background-color: ${withHashtag.base0D}59;
        }

        [data-theme="stylix"] .mantine-Button-root:hover {
          box-shadow: 0 0 12px ${withHashtag.base0D}40;
        }

        [data-theme="stylix"] .mantine-Card-root {
          border: 1px solid ${withHashtag.base02};
        }

        [data-theme="stylix"] .active,
        [data-theme="stylix"] [aria-selected="true"] {
          background: ${withHashtag.base0D}26;
          color: ${withHashtag.base05};
        }

        [data-theme="stylix"] tr:hover,
        [data-theme="stylix"] .mantine-Table-tr:hover {
          background: ${withHashtag.base01};
        }

        [data-theme="stylix"] .mantine-Slider-track {
          background: ${withHashtag.base0D};
        }

        [data-theme="stylix"] a {
          color: ${withHashtag.base0D};
        }

        [data-theme="stylix"] a:hover {
          color: ${withHashtag.base0C};
        }
      '';

      themeDirs = [
        ".config/feishin"
      ]
      ++ lib.optional cfg.dev.enable ".config/feishin-dev";
    in
    {
      home.file = builtins.listToAttrs (
        lib.concatMap (dir: [
          {
            name = "${dir}/Themes/stylix.json";
            value.text = themeJson;
          }
          {
            name = "${dir}/Themes/stylix.css";
            value.text = themeCss;
          }
        ]) themeDirs
      );
    };
}
