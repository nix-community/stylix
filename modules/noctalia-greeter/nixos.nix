{
  lib,
  mkTarget,
  options,
  ...
}:
mkTarget {
  # TODO: Add support for integrated noctalia-greeter
  # Looks like we can share all of the following options
  # https://github.com/NixOS/nixpkgs/pull/540530
  config = lib.optionals (options.programs ? noctalia) [
    ({ colors }: {
      programs.noctalia-greeter.settings.appearance = {
        scheme = "Synced";
        palette = with colors.withHashtag; {
          primary = base0D;
          on_primary = base00;
          secondary = base0E;
          on_secondary = base00;
          tertiary = base0C;
          on_tertiary = base00;
          error = base08;
          on_error = base00;
          surface = base00;
          on_surface = base05;
          surface_variant = base01;
          on_surface_variant = base04;
          outline = base03;
          shadow = base00;
          hover = base0C;
          on_hover = base00;
        };
      };
    })
    ({ cursor }: {
      programs.noctalia-greeter.settings.cursor = {
        inherit (cursor) size;
        theme = cursor.name;
        path = "${cursor.package}/share/icons";
      };
    })
    ({ polarity }: {
      programs.noctalia-greeter.settings.appearance.theme_mode =
        if polarity == "dark" then polarity else "light";
    })
    ({ fonts }: {
      programs.noctalia-greeter.settings.appearance.font_family =
        fonts.sansSerif.name;
    })
    ({ image }: {
      programs.noctalia-greeter.settings.appearance.wallpaper.path = image;
    })
  ];
}
