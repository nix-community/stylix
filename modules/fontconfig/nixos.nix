{ lib, mkTarget, ... }:
{
  imports = lib.singleton (
    lib.modules.importApply ./fontconfig.nix { inherit mkTarget; }
  );
}
