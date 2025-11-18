{ lib, pkgs, ... }:
{
  config = {
    stylix.testbed.ui.graphicalEnvironment = "kde";

    services.displayManager.autoLogin.enable = lib.mkForce false;

    home-manager.sharedModules = lib.singleton {
      stylix.targets.kde = {
        enable = true;
        applicationStyle = "Utterly-Round";
        widgetStyle = "Darkly";
      };
      home.packages = with pkgs; [
        darkly
        darkly-qt5
        utterly-round-plasma-style
      ];
    };
  };
}
