{ lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.subsystem-maintainers = pkgs.writeText "subsystem-maintainers" (
        lib.pipe ../../stylix/meta.nix [
          (lib.flip pkgs.callPackage { })
          (lib.mapAttrs (
            _: meta: map (maintainer: maintainer.github) (meta.maintainers or [ ])
          ))
          (lib.mapAttrs' (name: lib.nameValuePair "modules/${name}/"))
          builtins.toJSON
        ]
      );
    };
}
