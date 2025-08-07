{ inputs, ... }:
{
  perSystem =
    { lib, pkgs, ... }:
    {
      checks = lib.mkMerge (
        map
          (
            input:
            let
              name = "${input}-and-dev-${input}-version-consistency";
            in
            {
              ${name} =
                let
                  dev = inputs."dev-${input}".narHash;
                  public = inputs.${input}.narHash;
                in
                pkgs.runCommand name { } ''
                  if [ "${public}" != "${dev}" ]; then
                    printf \
                      'inconsistent ${input} (%s) and dev-${input} (%s) versions\n' \
                      "${public}" \
                      "${dev}" \
                      >&2

                    exit 1
                  fi

                  mkdir "$out"
                '';
            }
          )
          [
            "flake-parts"
            "nixpkgs"
            "systems"
          ]
      );
    };
}
