{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      checks.nixpkgs-and-dev-nixpkgs-version-consistency =
        pkgs.runCommand "nixpkgs-and-dev-nixpkgs-version-consistency"
          {
            dev_nixpkgs = inputs.dev-nixpkgs.narHash;
            nixpkgs = inputs.nixpkgs.narHash;
          }
          ''
            if [ "$nixpkgs" != "$dev_nixpkgs" ]; then
              printf \
                'inconsistent nixpkgs (%s) and dev-nixpkgs (%s) versions\n' \
                "$nixpkgs" \
                "$dev_nixpkgs" \
                >&2
              exit 1
            fi
            mkdir "$out"
          '';
    };
}
