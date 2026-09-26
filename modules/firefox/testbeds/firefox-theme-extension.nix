{ lib, pkgs, ... }:
let
  package = pkgs.firefox-devedition;
  profileName = "dev-edition-default";
in
{
  stylix.testbed.ui.application = {
    name = "firefox-devedition";
    inherit package;
  };

  home-manager.sharedModules = lib.singleton {
    programs.firefox = {
      enable = true;
      inherit package;
      profiles.${profileName}.isDefault = true;
    };

    stylix.targets.firefox = {
      profileNames = [ profileName ];
      themeExtension.enable = true;
    };
  };
}
