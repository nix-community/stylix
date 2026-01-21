{ config, lib, ... }:
{
  overlay =
    _final: prev:
    lib.optionalAttrs
      (config.stylix.enable && config.stylix.targets.libadwaita.enable or false)
      {
        libadwaita = prev.libadwaita.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or [ ]) ++ [ ./load-custom-theme.patch ];
        });
      };
}
