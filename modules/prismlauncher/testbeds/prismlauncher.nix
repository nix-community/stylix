{ lib, pkgs, ... }:
let
  package = pkgs.prismlauncher;
in
{
  stylix.testbed.ui.application = {
    name = "org.prismlauncher.PrismLauncher";
    inherit package;
  };

  home-manager.sharedModules = lib.singleton {
    programs.prismlauncher = {
      enable = true;
      inherit package;
    };
  };
}
