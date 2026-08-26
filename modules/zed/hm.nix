{ mkTarget, ... }:
mkTarget {
  config = [
    ({ fonts }: {
      programs.zed-editor = {
        userSettings = {
          "buffer_font_family" = fonts.monospace.name;
          "buffer_font_size" = fonts.sizes.terminal.px;
          "ui_font_family" = fonts.sansSerif.name;
          "ui_font_size" = fonts.sizes.applications.px;
        };
      };
    })
    ({ colors, inputs }: {
      programs.zed-editor = {
        userSettings.theme = "Base16 ${colors.scheme-name}";
        themes.stylix = colors {
          templateRepo = inputs.tinted-zed;
          target = "base16";
        };
      };
    })
  ];
}
