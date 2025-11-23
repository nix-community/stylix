{
  lib,
  pkgs,
  ...
}:
{
  config = {
    stylix.testbed.ui.graphicalEnvironment = "kde";
    services.displayManager.autoLogin.enable = lib.mkForce false;
    home-manager.sharedModules = lib.singleton {
      home.packages = [
        pkgs.darkly
        pkgs.darkly-qt5
        pkgs.utterly-round-plasma-style
      ];
      stylix.targets.kde = {
        widgetStyle = "Darkly";
        applicationStyle = "Utterly-Round";
      };
    };

  };
}
