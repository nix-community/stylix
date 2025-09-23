{
  mkTarget,
  config,
  lib,
  ...
}:
mkTarget {
  name = "jankyborders";
  humanName = "JankyBorders";

  configElements =
    { colors, opacity }:
    {
      services.jankyborders =
        let
          mkOpacityHexColor = lib.flip config.lib.stylix.mkOpacityHexColor opacity.desktop;
        in
        {
          active_color = mkOpacityHexColor colors.base0D;
          inactive_color = mkOpacityHexColor colors.base03;
        };
    };
}
