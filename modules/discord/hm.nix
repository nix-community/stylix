{ mkTarget, lib, ... }:
{
  imports = map (module: lib.modules.importApply module mkTarget) [
    ./nixcord.nix
    ./vencord.nix
    ./vesktop.nix
  ];
}
