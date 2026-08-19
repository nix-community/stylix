{ pkgs, lib, ... }: {
  stylix.testbed.ui.application = {
    name = "feishin";
    package = pkgs.feishin;
  };

  home-manager.sharedModules = lib.singleton {
    home.packages = [ pkgs.feishin ];
    stylix.targets.feishin.dev.enable = true;
  };
}
