{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.partitions
    ./deprecation
    ./modules.nix
    ./packages.nix
  ];

  partitions.dev = {
    module = ./dev;
    extraInputsFlake = ./dev;
  };

  partitionedAttrs = {
    checks = "dev";
    devShells = "dev";
    formatter = "dev";
  };
}
