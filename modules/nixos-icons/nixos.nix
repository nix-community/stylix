{
  lib,
  mkTarget,
  pkgs,
  ...
}:
mkTarget { config = import ./common.nix { inherit lib pkgs; }; }
