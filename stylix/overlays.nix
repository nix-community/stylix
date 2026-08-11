{
  lib,
  pkgs,
  config,
  options,
  ...
}@args:
let
  # Home manager check
  # This will default overlays to false *if* `home-manager.useGlobalPkgs` is enabled
  globalPackagesEnabled = args.osConfig.home-manager.useGlobalPkgs or false;
in
{
  options.stylix.overlays.enable =
    config.lib.stylix.mkEnableTarget "packages via overlays"
      (!globalPackagesEnabled);

  imports = map (
    f:
    let
      file = import f;
      attrs =
        if builtins.isFunction file then
          file {
            inherit
              lib
              pkgs
              config
              options
              ;
          }
        else
          file;
    in
    {
      _file = f;
      options = attrs.options or { };
      config.nixpkgs.overlays = lib.mkIf config.stylix.overlays.enable [
        attrs.overlay
      ];
    }
  ) (import ./autoload.nix { inherit lib pkgs; } "overlay");
}
