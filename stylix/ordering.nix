{ lib, ... }:
{
  options.stylix.listTargetIndex = lib.mkOption {
    description = ''
      The target index at which stylix inserts into lists.
      Intended for use as argument to `lib.mkOrder`.
    '';
    type = lib.types.int;
    default = 600;
    internal = true;
    readOnly = true;
  };
}
