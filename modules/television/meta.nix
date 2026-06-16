{ lib, ... }:
{
  name = "Television";
  homepage = "https://github.com/alexpasmantier/television";
  maintainers = [ lib.maintainers.csanthiago ];
  description = ''
    A cross-platform, fast, extensible fuzzy finder for the terminal,
    also known as `tv`. Colors are applied via theme files in the Home
    Manager [themes](https://github.com/nix-community/home-manager/blob/master/modules/programs/television.nix) option.
  '';
}
