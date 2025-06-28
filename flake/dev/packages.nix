{ lib, inputs, ... }:
{
  perSystem =
    { pkgs, config, ... }:
    {
      # Build all packages with 'nix flake check' instead of only verifying they
      # are derivations.
      checks = config.packages;

      # Testbeds are virtual machines based on NixOS, therefore they are
      # only available for Linux systems.
      packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux (
        import ../../stylix/testbed/default.nix {
          inherit pkgs inputs lib;
        }
      );
    };
}
