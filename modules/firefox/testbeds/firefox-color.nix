{ lib, ... }:
{
  imports = [ ./firefox.nix ];

  home-manager.sharedModules = lib.singleton {
    stylix.targets.firefox.colorTheme.enable = true;
    programs.firefox.profiles.stylix.extensions.force = true;
  };
}
