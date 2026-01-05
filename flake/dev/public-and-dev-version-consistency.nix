{ inputs, ... }:
{
  perSystem =
    {
      lib,
      pkgs,
      system,
      ...
    }:
    let
      checks = lib.genAttrs' [ "flake-parts" "nixpkgs" "systems" ] (
        input:
        let
          name = "${input}-and-dev-${input}-version-consistency";
        in
        lib.nameValuePair name (
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
          ''
        )
      );
    in
    {
      inherit checks;

      ci.buildbot = lib.mkIf (system == "x86_64-linux") {
        public-and-dev-version-consistency = pkgs.linkFarm "public-and-dev-version-consistency" checks;
      };
    };
}
