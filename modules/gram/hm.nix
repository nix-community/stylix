{ mkTarget, ... }:
mkTarget {
  config = [
    ({ fonts }: {
      programs.gram.settings = {
        "buffer_font_family" = fonts.monospace.name;
        "buffer_font_size" = fonts.sizes.terminal * 4.0 / 3.0;
        "ui_font_family" = fonts.sansSerif.name;
        "ui_font_size" = fonts.sizes.applications * 4.0 / 3.0;
      };
    })
    ({ colors, inputs }: {
      programs.gram.settings.theme = "Base16 ${colors.scheme-name}";
      xdg.configFile."gram/themes/stylix.json".source = colors {
        templateRepo = inputs.tinted-zed;
        target = "base16";
      };
    })
  ];
}
