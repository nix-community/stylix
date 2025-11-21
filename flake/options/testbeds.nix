{ lib, ... }:
{
  perSystem.options.testbeds = lib.mkOption {
    internal = true;
    type = lib.types.lazyAttrsOf lib.types.package;
    default = { };
    description = "Testbeds for Stylix.";
  };
}
