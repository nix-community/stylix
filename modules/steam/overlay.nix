{ config, lib, ... }:
{
  overlay =
    _final: prev:
    lib.optionalAttrs
      (config.stylix.enable && config.stylix.targets.steam.enable or false)
      {
        adwsteamgtk = prev.adwsteamgtk.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or [ ]) ++ [ ./fix_custom_css_permissions.patch ];
        });
      };
}
