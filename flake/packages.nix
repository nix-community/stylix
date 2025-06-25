{ lib, inputs, ... }:
{

  perSystem =
    { pkgs, config, ... }:
    {
      # Build all packages with 'nix flake check' instead of only verifying they
      # are derivations.
      checks = config.packages;

      # Make 'nix run .#doc' serve the documentation site
      apps.doc.program = config.packages.serve-docs;

      packages = lib.mkMerge [
        # Testbeds are virtual machines based on NixOS, therefore they are
        # only available for Linux systems.
        (lib.mkIf pkgs.stdenv.hostPlatform.isLinux (
          import ../stylix/testbed {
            inherit pkgs inputs lib;
          }
        ))
        {
          doc = pkgs.callPackage ../doc {
            inherit (inputs) self;
          };
          serve-docs = pkgs.callPackage ../doc/server.nix {
            inherit (config.packages) doc;
          };
          palette-generator = pkgs.callPackage ../palette-generator { };
        }
      ];
    };
}
