{ lib, ... }:
{
  imports = [ ./firefox.nix ];

  home-manager.sharedModules = lib.singleton {
    stylix.targets.firefox.firefoxGnomeTheme.enable = true;
  };
}
