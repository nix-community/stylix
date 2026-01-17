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
              icon_theme =
                if config.stylix.polarity == "dark" then
                  config.stylix.icons.dark
                else
                  config.stylix.icons.light;
            };

            urgency_low = {
              background = base01 + dunstOpacity;
              foreground = base05;
              frame_color = base03;
            };

            urgency_normal = {
              background = base01 + dunstOpacity;
              foreground = base05;
              frame_color = base0D;
            };

            urgency_critical = {
              background = base01 + dunstOpacity;
              foreground = base05;
              frame_color = base08;
            };
          };
      }
    )
  ];
}
