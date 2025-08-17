{ lib, ... }:
let
  profileName = "stylix";
in
{
  stylix.testbed.ui.command.text = "zen";

  home-manager.sharedModules = lib.singleton {
    programs.zen-browser = {
      enable = true;
      profiles.${profileName} = {
        isDefault = true;
        settings = {
          "app.normandy.first_run" = false;
          "zen.welcome-screen.seen" = true;
        };
      };
    };

    stylix.targets.zen-browser.profileNames = [ profileName ];
  };
}
