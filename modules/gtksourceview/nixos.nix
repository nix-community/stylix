{ lib, mkTarget, ... }:
mkTarget { config = import ./common.nix { inherit lib; }; }
