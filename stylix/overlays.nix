{
  lib,
  pkgs,
  config,
  options,
  ...
}@args:
let
  # Only passed when Home Manager runs as a NixOS module, which is where
  # `home-manager.useGlobalPkgs` is defined. Not declared as a function
  # argument, so the module system does not require it to exist.
  osConfig = args.osConfig or { };
in
{
  options.stylix.overlays.enable = config.lib.stylix.mkEnableTarget "packages via overlays" true;

  # `home-manager.useGlobalPkgs` forbids `nixpkgs.overlays`. Stylix's
  # home-manager-integration only disables overlays when it auto-imports the
  # module, so a manually imported Home Manager module must disable them here.
  config.stylix.overlays.enable = lib.mkIf (osConfig.home-manager.useGlobalPkgs or false) false;

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
