{ mkTarget, lib, ... }:
{
  imports = map (module: lib.modules.importApply module mkTarget) [
    ./nixvim.nix
    ./nvf.nix
  ];
}
