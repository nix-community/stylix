{ mkTarget, lib, ... }:
mkTarget {
  config = [
    (
      { fonts }:
      {
        services.dunst.settings.global.font =
          "${fonts.sansSerif.name} ${toString fonts.sizes.popups}";
      }
    )
    (
      { colors, opacity }:
      {
        services.dunst.settings =
          with colors.withHashtag;
          let
            dunstOpacity = lib.toHexString (
              ((builtins.floor (opacity.popups * 100 + 0.5)) * 255) / 100
            );
          in
          {
            global = {
              separator_color = base02;
            };

            urgency_low = {
              background = base01 + dunstOpacity;
              foreground = base05;
              frame_color = base03;
              highlight = base03;
            };

            urgency_normal = {
              background = base01 + dunstOpacity;
              foreground = base05;
              frame_color = base0D;
              highlight = base0D;
            };

            urgency_critical = {
              background = base01 + dunstOpacity;
              foreground = base05;
              frame_color = base08;
              highlight = base08;
            };
          };
      }
    )
    (
      { polarity, icons }:
      {
        services.dunst = {
          iconTheme = {
            inherit (icons) package;
            name = if polarity == "dark" then icons.dark else icons.light;
          };
        };
      }
    )
  ];
}
