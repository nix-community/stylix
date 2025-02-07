{ mkTarget, config, ... }:
mkTarget {
  name = "jankyborders";
  humanName = "JankyBorders";

  configElements =
    { colors }:
    {
      services.jankyborders = {
        active_color = config.lib.stylix.mkOpacityHexColor colors.base0D config.stylix.opacity.desktop;
        inactive_color = config.lib.stylix.mkOpacityHexColor colors.base03 config.stylix.opacity.desktop;
      };
    };
}
