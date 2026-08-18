{ mkTarget, lib, ... }:
mkTarget {
  options.dev.enable = lib.mkEnableOption "installing the theme for the Feishin development build (`~/.config/feishin-dev`) in addition to the stable build";

  config =
    {
      cfg,
      colors,
      polarity,
    }:
    let
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
            value.text = builtins.toJSON {
              mode = if polarity == "dark" then polarity else "light";

              colors = with colors.withHashtag; {
                background = base00;
                background-alternate = base01;
                surface = base01;
                surface-foreground = base06;
                foreground = base05;
                foreground-muted = base03;

                primary = base0D;

                state-info = base0D;
                state-success = base0B;
                state-warning = base0A;
                state-error = base08;

                black = base00;
                white = base07;
              };

              app = with colors.withHashtag; {
                overlay-header = "linear-gradient(transparent 0%, ${base00}D9 100%), var(--theme-background-noise)";
                overlay-subheader = "linear-gradient(180deg, ${base00}0D 0%, var(--theme-colors-background) 100%), var(--theme-background-noise)";
                scrollbar-handle-background = "${base0D}33";
                scrollbar-handle-hover-background = "${base0D}66";
              };

              stylesheets = [ "stylix.css" ];
            };
          }
          {
            name = "${dir}/Themes/stylix.css";
            value.text = with colors.withHashtag; ''
              [data-theme="stylix"] ::selection {
                background-color: ${base0D}59;
              }

              [data-theme="stylix"] .mantine-Button-root:hover {
                box-shadow: 0 0 12px ${base0D}40;
              }

              [data-theme="stylix"] .mantine-Card-root {
                border: 1px solid ${base02};
              }

              [data-theme="stylix"] .active,
              [data-theme="stylix"] [aria-selected="true"] {
                background: ${base0D}26;
                color: ${base05};
              }

              [data-theme="stylix"] tr:hover,
              [data-theme="stylix"] .mantine-Table-tr:hover {
                background: ${base01};
              }

              [data-theme="stylix"] .mantine-Slider-track {
                background: ${base0D};
              }

              [data-theme="stylix"] a {
                color: ${base0D};
              }

              [data-theme="stylix"] a:hover {
                color: ${base0C};
              }
            '';
          }
        ]) themeDirs
      );
    };
}
