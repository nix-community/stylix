{ lib, pkgs, ... }:
let
  package = pkgs.ptyxis;
in
{
  stylix.testbed.ui.application = {
    name = "org.gnome.Ptyxis";
    inherit package;
  };

  home-manager.sharedModules = lib.singleton {
    programs.ptyxis = {
      enable = true;
      inherit package;
    };

    stylix.targets.ptyxis.profileUUIDs = [ "00000000-0000-0000-0000-000000000000" ];

    dconf.settings."org/gnome/Ptyxis" = {
      default-profile-uuid = "00000000-0000-0000-0000-000000000000";
      profile-uuids = [ "00000000-0000-0000-0000-000000000000" ];
    };
  };
}
