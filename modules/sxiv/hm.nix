{ mkTarget, ... }:
mkTarget {
  autoEnable = { config, ... }: config.stylix.targets.x11.enable;
  autoEnableExpr = "config.stylix.targets.x11.enable";

  config = [
    ({ fonts }: {
      xresources.properties."Sxiv.font" =
        "${fonts.sansSerif.name}-${toString fonts.sizes.applications}";
    })
    ({ colors }: {
      xresources.properties = {
        "Sxiv.foreground" = "#${colors.base01}";
        "Sxiv.background" = "#${colors.base04}";
      };
    })
  ];
}
