{
  mkTarget,
  config,
  lib,
  pkgs,
  ...
}:
mkTarget {
  config = { colors, opacity }: {
    services.jankyborders.settings =
      let
        mkOpacityHexColor = lib.flip config.lib.stylix.mkOpacityHexColor opacity.desktop;
      in
      lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
        active_color = mkOpacityHexColor colors.base0D;
        inactive_color = mkOpacityHexColor colors.base03;
      };
  };
}
