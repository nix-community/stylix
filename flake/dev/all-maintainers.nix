{ lib, ... }:
{
  perSystem =
    { pkgs, config, ... }:
    {
      apps.all-maintainers = {
        program = pkgs.writeShellApplication {
          name = "update-all-maintainers";
          runtimeInputs = [ pkgs.gitMinimal ];
          text = ''
            root="$(git rev-parse --show-toplevel)"
            cp --force \
              ${config.packages.all-maintainers} \
              "$root/generated/all-maintainers.nix"
          '';
        };
        meta.description = "Update generated/all-maintainers.nix.";
      };

      packages.all-maintainers =
        pkgs.runCommand "all-maintainers"
          {
            passAsFile = [ "allMaintainers" ];
            allMaintainers = ''
              # DO NOT EDIT THIS GENERATED FILE.
              #
              # This file lists Stylix module maintainers for GitHub review
              # requests, per NixOS RFC 39.
              #
              # To generate this file, run:
              #
              #       nix run .#all-maintainers
              ${lib.pipe ../../stylix/meta.nix [
                (lib.flip pkgs.callPackage { })
                builtins.attrValues
                (builtins.concatMap (target: target.maintainers or [ ]))
                (map (maintainer: lib.nameValuePair maintainer.github maintainer))
                builtins.listToAttrs
                (lib.generators.toPretty { })
              ]}
            '';
            inherit (config.treefmt) projectRootFile;
            nativeBuildInputs = [ config.formatter ];
          }
          ''
            touch "$projectRootFile"
            cp "$allMaintainersPath" all-maintainers.nix
            treefmt --no-cache all-maintainers.nix
            install -m 644 -T all-maintainers.nix "$out"
          '';
    };
}
