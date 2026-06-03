{ mkTarget, lib, ... }:
{
  imports = map (module: lib.modules.importApply module mkTarget) [
    ./tint.nix
    ./desktoppr.nix
  ];
}
