{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      checks.nixpkgs-and-dev-nixpkgs-version-consistency =
        pkgs.runCommand "nixpkgs-rev"
          {
            root = inputs.nixpkgs.narHash;
            dev = inputs.dev-nixpkgs.narHash;
          }
          ''
            if [ "$root" != "$dev" ]; then
              echo "Expected inputs.nixpkgs to match inputs.dev-nixpkgs"
              echo "inputs.nixpkgs: $root"
              echo "inputs.dev-nixpkgs: $dev"
              exit 1
            fi
            touch "$out"
          '';
    };
}
