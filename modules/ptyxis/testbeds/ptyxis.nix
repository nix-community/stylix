{ lib, pkgs, ... }:
let
  package = pkgs.ptyxis;
in
{
  stylix.testbed.ui.application = {
    name = "org.gnome.Ptyxis";
    inherit package;
  };

  home-manager.sharedModules = lib.singleton (
    { config, ... }:
    {
      programs.ptyxis = {
        enable = true;
        inherit package;
      };

      stylix.targets.ptyxis.profileUUIDs = [ "00000000000000000000000000000000" ];

      dconf.settings."org/gnome/Ptyxis".profile-uuids =
        config.stylix.targets.ptyxis.profileUUIDs;
    }
  );
}
