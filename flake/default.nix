{ inputs, lib, ... }:
{
  imports = [
    # keep-sorted start
    ./deprecation
    ./modules.nix
    ./packages.nix
    ./propagated-packages.nix
    inputs.flake-parts.flakeModules.partitions
    # keep-sorted end
  ];

  partitions.dev = {
    module = ./dev;
    extraInputsFlake = ./dev;
  };

  partitionedAttrs = lib.genAttrs [
    # keep-sorted start
    "checks"
    "devShells"
    "formatter"
    # keep-sorted end
  ] (_: "dev");
}
