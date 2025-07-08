{
  lib,
  pkgs,
}:

/**
  Creates a minimal configuration to extract the `stylix.testbed.enable` option
  value.

  This is for performance reasons. Primarily, to avoid fully evaluating testbed
  system configurations to determine flake outputs.
  E.g., when running `nix flake show`.
*/
module:
let
  minimal = lib.evalModules {
    modules = [
      ./modules/enable.nix
      module
      { _module.args = { inherit pkgs; }; }
      { _module.check = false; }
    ];
  };
in
minimal.config.stylix.testbed.enable
