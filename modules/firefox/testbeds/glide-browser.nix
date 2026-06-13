{ lib, ... }:
let
  profileName = "stylix";
in
{
  stylix.testbed.ui.command.text = "glide";

  home-manager.sharedModules = lib.singleton {
    programs.glide-browser = {
      enable = true;
      profiles.${profileName}.isDefault = true;
    };

    stylix.targets.glide-browser.profileNames = [ profileName ];
  };
}
