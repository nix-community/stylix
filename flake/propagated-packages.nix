{
  lib,
  config,
  partitionStack,
  ...
}:
{
  # For any output attrs normally defined by the public flake configuration,
  # any exceptions must be manually propagated from the `dev` partition.
  #
  # NOTE: Attrs should be explicitly propagated at the deepest level.
  # Otherwise the partition won't be lazy, making it pointless.
  # E.g. propagate `packages.${system}.foo` instead of `packages.${system}`
  # See: https://github.com/hercules-ci/flake-parts/issues/258
  perSystem =
    { pkgs, system, ... }:
    lib.optionalAttrs (partitionStack == [ ]) {
      packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux (
        lib.mapAttrs (
          name: _: config.partitions.dev.module.flake.packages.${system}.${name}
        ) (import ../stylix/testbed/autoload.nix { inherit lib pkgs; })
      );
    };
}
