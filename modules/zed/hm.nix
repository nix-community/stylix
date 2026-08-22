{
  lib,
  config,
  mkTarget,
  ...
}:
mkTarget {
  config = [
    ({ fonts }: {
      programs.zed-editor = {
        userSettings = {
          "buffer_font_family" = fonts.monospace.name;
          "buffer_font_size" = fonts.sizes.terminal * 4.0 / 3.0;
          "ui_font_family" = fonts.sansSerif.name;
          "ui_font_size" = fonts.sizes.applications * 4.0 / 3.0;
        };
      };
    })
    (
      {
        inputs,
        colors,
        opacity,
      }:
      {
        programs.zed-editor = {
          userSettings = {
            theme = "Base16 ${colors.scheme-name}";
            "experimental.theme_overrides" =
              with colors;
              let
                mkOpacityHexColor =
                  color:
                  let
                    hex = builtins.substring 2 (-1) (
                      config.lib.stylix.mkOpacityHexColor color opacity.desktop
                    );
                  in
                  lib.toLower "${builtins.substring 2 (-1) hex}${builtins.substring 0 2 hex}";
              in
              if (opacity.desktop != 1.0) then
                {
                  "background" = "#${mkOpacityHexColor base00}";
                  "surface.background" = "#${mkOpacityHexColor base00}";
                  "title_bar.background" = "#${mkOpacityHexColor base00}";
                  "title_bar.inactive.background" = "#00000000";
                  "editor.background" = "#00000000";
                  "editor.gutter.background" = "#00000000";
                  "panel.background" = "#00000000";
                  "toolbar.background" = "#00000000";
                  "tab_bar.background" = "#00000000";
                  "tab.active_background" = "#00000000";
                  "tab.inactive_background" = "#00000000";
                  "terminal.background" = "#00000000";

                }
              else
                { };
          };
          themes.stylix = colors {
            templateRepo = inputs.tinted-zed;
            target = "base16";
          };
        };
      }
    )
  ];
}
