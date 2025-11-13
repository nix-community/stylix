inputs:
{ lib, ... }:
{
  home-manager.sharedModules = lib.singleton {
    home.file.flake-parts.source = inputs.flake-parts;
  };
}
