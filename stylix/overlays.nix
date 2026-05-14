{ config, ... }:
{
  options.stylix.overlays.enable = config.lib.stylix.mkEnableTarget "packages via overlays" true;
}
