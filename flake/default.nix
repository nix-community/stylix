{ inputs, lib, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.partitions
    ./deprecation
    ./modules.nix
    ./packages.nix
    ./propagated-packages.nix
  ];

  partitions.dev = {
    module = ./dev;
    extraInputsFlake = ./dev;
  };

  partitionedAttrs = lib.genAttrs [
    "checks"
    "devShells"
    "formatter"
  ] (_: "dev");
}
