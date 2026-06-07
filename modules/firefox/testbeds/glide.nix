{ lib, pkgs, inputs, ... }:
let
  package = inputs.glide.packages.${pkgs.stdenv.hostPlatform.system}.default;
  profileName = "stylix";
in
{
  stylix.testbed.ui.application = {
    name = "glide";
    inherit package;
  };

  home-manager.sharedModules = lib.singleton {
    programs.glide-browser = {
      enable = true;
      inherit package;
      profiles.${profileName}.isDefault = true;
    };

    stylix.targets.glide-browser.profileNames = [ profileName ];
  };
}
