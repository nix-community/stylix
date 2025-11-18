{ inputs, lib, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.partitions
    ./options/ci.nix
    ./options/testbeds.nix
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
    "ci"
    "devShells"
    "formatter"
  ] (_: "dev");
}
