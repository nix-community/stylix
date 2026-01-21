{ config, lib, ... }:

{
  overlay =
    _final: prev:
    lib.optionalAttrs
      (
        config.stylix.enable
        && config.stylix.targets ? libadwaita
        && config.stylix.targets.libadwaita.enable
      )
      {
        libadwaita = prev.libadwaita.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or [ ]) ++ [ ./load-custom-theme.patch ];
        });
      };
}
