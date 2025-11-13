{ lib }:
lib.pipe ./graphical-environments [
  builtins.readDir
  (lib.mapAttrsToList (name: _: lib.removeSuffix ".nix" name))
]
