{
  mkTarget,
  config,
  lib,
  ...
}:
mkTarget {
  requiredOptions = [
    [
      "services"
      "jankyborders"
      "active_color"
    ]
  ];

  config = { colors, opacity }: {
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
