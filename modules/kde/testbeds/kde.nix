{ lib, pkgs, ... }:
{
  stylix.testbed.ui = {
    command.packages = [ pkgs.kitty ];
    graphicalEnvironment = "kde";
  };

  services.displayManager.autoLogin.enable = lib.mkForce false;
}
