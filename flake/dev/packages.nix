{ lib, inputs, ... }:
{
  perSystem =
    { pkgs, config, ... }:
    {
      # Build all packages with 'nix flake check' instead of only verifying they
      # are derivations.
      checks = config.packages;

      packages = config.testbeds;

      # Testbeds are virtual machines based on NixOS, therefore they are
      # only available for Linux systems.
      testbeds = lib.mkIf pkgs.stdenv.hostPlatform.isLinux (
        import ../../stylix/testbed { inherit pkgs inputs lib; }
      );

      ci.buildbot = {
        packages = builtins.removeAttrs config.packages (
          builtins.attrNames config.testbeds
        );
        # Batching testbeds by target, to avoid overwhelming buildbot
        testbeds = lib.pipe config.testbeds [
          (lib.mapAttrsToList (
            name: testbed:
            let
              # name is formatted as `testbed:target:variant` e.g. `testbed:alacritty:dark`
              splitName = lib.splitString ":" name;
            in
            {
              target = builtins.elemAt splitName 1;
              variant = builtins.elemAt splitName 2;
              inherit testbed;
            }
          ))
          (builtins.groupBy (entry: entry.target))
          (lib.mapAttrs (_: builtins.groupBy (entry: entry.variant)))
          (lib.mapAttrs (
            _:
            lib.mapAttrs (
              _: entries:
              assert lib.length entries == 1;
              (lib.head entries).testbed
            )
          ))
          (lib.mapAttrs (target: pkgs.linkFarm "testbeds-${target}"))
        ];
      };
    };
}
