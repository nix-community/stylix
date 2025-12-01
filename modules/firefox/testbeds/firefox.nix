{ lib, ... }:
{
  stylix.testbed.ui.command.text = "firefox";

  home-manager.sharedModules =
    let
      profileName = "stylix";
    in
    lib.singleton {
      programs.firefox = {
        enable = true;
        profiles.${profileName}.isDefault = true;
      };

      stylix.targets.firefox.profileNames = [ profileName ];
    };
}
