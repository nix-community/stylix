{ config, lib, ... }:

{
  overlay =
    _final: prev:
    lib.optionalAttrs
      (
        config.stylix.enable
        && config.stylix.targets ? gtk
        && config.stylix.targets.gtk.enable
      )
      {
        libadwaita = prev.libadwaita.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or [ ]) ++ [ ./libadwaita-load-custom-theme.patch ];
        });
      };
}
