{ lib, mkTarget, ... }:
{
  imports =
    lib.mapAttrsToList
      (
        name: humanName:
        lib.modules.importApply ./each-config.nix { inherit mkTarget name humanName; }
      )
      {
        "vscode" = "VSCode";
        "vscodium" = "VSCodium";
      };
}
