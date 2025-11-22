{ inputs, lib, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.partitions
    ./deprecation
    ./modules.nix
    ./options/ci.nix
    ./options/testbeds.nix
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
