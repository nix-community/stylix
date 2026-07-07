{ lib, pkgs, ... }:
let
  package = pkgs.ptyxis;
  uuid = "00000000000000000000000000000000";
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

    stylix.targets.ptyxis.profileUUIDs = [ uuid ];

    dconf.settings."org/gnome/Ptyxis" = {
      profile-uuids = [ uuid ];
    };
  };
}
